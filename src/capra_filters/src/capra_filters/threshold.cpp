#include <capra_filters/filter.h>

#include <capra_filters/thresholdConfig.h>
#include <cv_bridge/cv_bridge.h>
#include <image_transport/image_transport.h>
#include <opencv2/imgproc/imgproc.hpp>

namespace capra_filters {

  class Threshold : public capra_filters::Filter<capra_filters::thresholdConfig> {

  public:
    Threshold() :
      min_(3), max_(3)
    {
    }

    virtual void configure(capra_filters::thresholdConfig& config, uint32_t level) {
      min_[0] = config.c1min;
      min_[1] = config.c2min;
      min_[2] = config.c3min;
      max_[0] = config.c1max;
      max_[1] = config.c2max;
      max_[2] = config.c3max;

      if(config.input != input_) {
        input_ = config.input;
        sub_.shutdown();
        sub_ = it_->subscribe(input_, 1, &Threshold::handleInput, this);
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

      cv::cvtColor(in->image, out.image, CV_BGR2HSV);
      cv::inRange(out.image, min_, max_, out.image);

      out.header = in->header;
      out.encoding = sensor_msgs::image_encodings::MONO8;

      pub_.publish(out.toImageMsg());
    }

  private:
    virtual void initialize() {
      it_ = boost::make_shared<image_transport::ImageTransport>(nh);
    }

    boost::shared_ptr<image_transport::ImageTransport> it_;

    image_transport::Publisher pub_;
    image_transport::Subscriber sub_;
    std::vector<int> min_, max_;
    std::string input_, output_;
  };

  PLUGINLIB_EXPORT_CLASS(capra_filters::Threshold, nodelet::Nodelet);
}
