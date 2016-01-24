#include <capra_filters/filter.h>

#include <capra_filters/section_filterConfig.h>
#include <cv_bridge/cv_bridge.h>
#include <image_transport/image_transport.h>
#include <opencv2/imgproc/imgproc.hpp>

namespace capra_filters {

  class SectionFilter : public capra_filters::Filter<capra_filters::section_filterConfig> {

  public:
    SectionFilter() {
    }

    virtual void configure(capra_filters::section_filterConfig& config, uint32_t level) {
      grass_min_ = config.grass_min;
      grass_max_ = config.grass_max;
      light_min_ = config.light_min;
      kernel_erode_height_ = config.kernel_erode_height;
      kernel_erode_width_ = config.kernel_erode_width;
      kernel_dilate_height_ = config.kernel_dilate_height;
      kernel_dilate_width_ = config.kernel_dilate_width;
      sections_ = config.sections;
      min_area_ = config.min_area;
      color_ = cv::Scalar(255, 255, 255);

      kerode_ = cv::getStructuringElement(cv::MORPH_CROSS,
                                          cv::Size(kernel_erode_width_, kernel_erode_height_));

      kdilate_ = cv::getStructuringElement(cv::MORPH_CROSS,
                                           cv::Size(kernel_dilate_width_, kernel_dilate_height_));


      if(config.input != input_) {
        input_ = config.input;
        sub_.shutdown();
        sub_ = it_->subscribe(input_, 1, &SectionFilter::handleInput, this);
      }

      if(config.output != output_) {
        output_ = config.output;
        pub_.shutdown();
        pub_ = it_->advertise(output_, 1);
      }
    }

    virtual void handleInput(const sensor_msgs::ImageConstPtr &msg) {
      cv_bridge::CvImagePtr cv_ptr;

      try {
        cv_ptr = cv_bridge::toCvCopy(msg, "bgr8");
      } catch(cv_bridge::Exception &e) {
        NODELET_ERROR_STREAM("cv_bridge exception: " << e.what());
      }

      cv::cvtColor(cv_ptr->image, cv_ptr->image, CV_BGR2HSV);
      cv::Mat hue = execute_remgrass(cv_ptr->image);
      hue = execute_section(hue);
      cv::Mat chans[] = {hue, hue, hue};
      cv::merge(chans, 3, cv_ptr->image);

      pub_.publish(cv_ptr->toImageMsg());
    }

    cv::Mat execute_remgrass(cv::Mat image) {
      std::vector<cv::Mat> chans(3);
      cv::split(image, chans);
      cv::Mat huemin = chans[0].clone();
      cv::Mat huemax = chans[0].clone();
      cv::threshold(chans[0], huemin, grass_min_, 255, cv::THRESH_BINARY_INV);
      cv::threshold(chans[0], huemax, grass_max_, 255, cv::THRESH_BINARY);

      cv::threshold(chans[2], chans[2], light_min_, 255, cv::THRESH_BINARY);

      cv::Mat hue;
      cv::bitwise_or(huemin, huemax, hue);
      cv::bitwise_and(chans[2], hue, hue);

      return hue;
    }

    cv::Mat execute_section(cv::Mat hue) {

      cv::erode(hue, hue, kerode_);

      cv::Size size = hue.size();
      int rows = size.height;
      int section_size = rows / sections_;

      cv::rectangle(hue, cv::Rect(0, 0, size.width, section_size), cv::Scalar(0, 0, 0), CV_FILLED);

      for(int i=0; i< sections_; i++) {
        int start = section_size * i;
        int end = section_size * (i + 1);
        if(end > rows) {
          end = rows;
        }

        cv::Mat section = hue.rowRange(start, end);

        std::vector<std::vector<cv::Point> > contours;
        std::vector<cv::Vec4i> hierarchy;
        cv::findContours(section, contours, hierarchy, CV_RETR_LIST, CV_CHAIN_APPROX_NONE );
        section = cv::Mat::zeros(section.size(), section.type());

        std::vector<std::vector<cv::Point> > hull(contours.size());

        for (size_t i = 0; i < contours.size(); i++) {
          cv::convexHull(cv::Mat(contours[i]), hull[i], false);
        }

        for (size_t i = 0; i < contours.size(); i++) {
          double area = abs(cv::contourArea(contours[i]));
          if(area > min_area_) {
            cv::drawContours(section, hull, i, color_, -1, 8, std::vector<cv::Vec4i>(), 0, cv::Point());
          }
        }
      }

      cv::dilate(hue, hue, kdilate_);

      return hue;
    }


  private:
    virtual void initialize() {
      it_ = boost::make_shared<image_transport::ImageTransport>(nh);
    }

    boost::shared_ptr<image_transport::ImageTransport> it_;

    image_transport::Publisher pub_;
    image_transport::Subscriber sub_;

    int grass_min_, grass_max_, light_min_,
      kernel_erode_height_, kernel_erode_width_,
      kernel_dilate_height_, kernel_dilate_width_,
      sections_, min_area_;

    cv::Scalar color_;
    cv::Mat kerode_, kdilate_;

    std::string input_, output_;
  };

  PLUGINLIB_EXPORT_CLASS(capra_filters::SectionFilter, nodelet::Nodelet);
}
