#include <capra_filters/filter.h>

#include <capra_filters/image_to_pointcloudConfig.h>
#include <cv_bridge/cv_bridge.h>
#include <image_transport/image_transport.h>
#include <opencv2/imgproc/imgproc.hpp>

namespace capra_filters {

  class ImageToPointcloud : public capra_filters::Filter<capra_filters::image_to_pointcloudConfig> {

  public:
    ImageToPointcloud() {
    }

    virtual void configure(capra_filters::image_to_pointcloudConfig& config, uint32_t level) {
      width_ = config.width;
      height_ = config.height;
      resolution_ = config.resolution;
      offset_x_ = config.offset_x;

      if(config.input != input_) {
        input_ = config.input;
        sub_.shutdown();
        sub_ = it_->subscribe(input_, 1, &ImageToPointcloud::handleInput, this);
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

      // TODO: transform image

      pub_.publish(out.toImageMsg());
    }

  private:
    virtual void initialize() {
      it_ = boost::make_shared<image_transport::ImageTransport>(nh);
    }

    boost::shared_ptr<image_transport::ImageTransport> it_;

    image_transport::Publisher pub_;
    image_transport::Subscriber sub_;

    int width_, height_, offset_x_, resolution_;
    std::string input_, output_;
  };

  PLUGINLIB_EXPORT_CLASS(capra_filters::ImageToPointcloud, nodelet::Nodelet);
}
