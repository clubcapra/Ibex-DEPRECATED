#include <capra_filters/filter.h>

#include <capra_filters/bgr2rgbConfig.h>
#include <cv_bridge/cv_bridge.h>
#include <image_transport/image_transport.h>
#include <opencv2/imgproc/imgproc.hpp>

namespace capra_filters {

  class Bgr2Rgb : public capra_filters::Filter<capra_filters::bgr2rgbConfig> {

  public:
    Bgr2Rgb() {
    }

    virtual void configure(capra_filters::bgr2rgbConfig& config, uint32_t level) {
      if(config.input != input_) {
        input_ = config.input;
        sub_.shutdown();
        sub_ = it_->subscribe(input_, 1, &Bgr2Rgb::handleInput, this);
      }

      if(config.output != output_) {
        output_ = config.output;
        pub_.shutdown();
        pub_ = it_->advertise(output_, 1);
      }
    }

    virtual void handleInput(const sensor_msgs::ImageConstPtr &msg) {
      cv_bridge::CvImageConstPtr in;
      cv_bridge::CvImage out;

      try {
        in = cv_bridge::toCvShare(msg);
      } catch(cv_bridge::Exception &e) {
        NODELET_ERROR_STREAM("cv_bridge exception: " << e.what());
      }

      out.header = in->header;
      out.encoding = in->encoding;

      cv::cvtColor(in->image, out.image, CV_BGR2RGB);

      pub_.publish(out.toImageMsg());
    }

  private:
    virtual void initialize() {
      it_ = boost::make_shared<image_transport::ImageTransport>(nh);
    }

    boost::shared_ptr<image_transport::ImageTransport> it_;

    image_transport::Publisher pub_;
    image_transport::Subscriber sub_;

    std::string input_, output_;
  };

  PLUGINLIB_EXPORT_CLASS(capra_filters::Bgr2Rgb, nodelet::Nodelet);
}
