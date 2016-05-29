#include <capra_filters/filter.h>

#include <capra_filters/flag_detectorConfig.h>
#include <cv_bridge/cv_bridge.h>
#include <image_transport/image_transport.h>
#include <opencv2/imgproc/imgproc.hpp>

namespace capra_filters {

  class FlagDetector : public capra_filters::Filter<capra_filters::flag_detectorConfig> {

  public:
    FlagDetector() {
    }

    virtual void configure(capra_filters::flag_detectorConfig& config, uint32_t level) {
      color_ = config.color;

      if(config.input != input_) {
        input_ = config.input;
        sub_.shutdown();
        sub_ = it_->subscribe(input_, 1, &FlagDetector::handleInput, this);
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
        cv_ptr = cv_bridge::toCvCopy(msg, "mono8");
      } catch(cv_bridge::Exception &e) {
        NODELET_ERROR_STREAM("cv_bridge exception: " << e.what());
      }

      cv::erode(cv_ptr->image, cv_ptr->image, cv::getStructuringElement(cv::MORPH_CROSS, cv::Size(5, 5)));
      cv::blur(cv_ptr->image, cv_ptr->image, cv::Size(20, 20));

      std::vector<std::vector<cv::Point> > contours;
      std::vector<cv::Vec4i> hierarchy;
      cv::Moments moments;
      int cx, cy, cxp;

      if(color_ == 0) { // red
        cxp = cv_ptr->image.cols;
      } else { // blue
        cxp = 0;
      }

      cv::findContours(cv_ptr->image, contours, hierarchy, cv::RETR_EXTERNAL, cv::CHAIN_APPROX_SIMPLE);

      for(auto& contour : contours) {
        moments = cv::moments(contour);
        cx = moments.m10 / moments.m00;
        cy = moments.m01 / moments.m00;

        cv::line(cv_ptr->image, cv::Point(cx, cy), cv::Point(cxp, cy), cv::Scalar(255, 0, 0), 10);
      }

      pub_.publish(cv_ptr->toImageMsg());
    }

  private:
    virtual void initialize() {
      it_ = boost::make_shared<image_transport::ImageTransport>(nh);
    }

    boost::shared_ptr<image_transport::ImageTransport> it_;

    image_transport::Publisher pub_;
    image_transport::Subscriber sub_;

    int color_;
    std::string input_, output_;
  };

  PLUGINLIB_EXPORT_CLASS(capra_filters::FlagDetector, nodelet::Nodelet);
}
