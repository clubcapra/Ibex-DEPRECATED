#include <capra_filters/filter.h>

#include <capra_filters/rectangleConfig.h>
#include <cv_bridge/cv_bridge.h>
#include <image_transport/image_transport.h>
#include <opencv2/imgproc/imgproc.hpp>

namespace capra_filters {

  class Rectangle : public capra_filters::Filter<capra_filters::rectangleConfig> {

  public:
    Rectangle() {
    }

    virtual void configure(capra_filters::rectangleConfig& config, uint32_t level) {
      x_ = config.x;
      y_ = config.y;
      width_ = config.width;
      height_ = config.height;

      if(config.input != input_) {
        input_ = config.input;
        sub_.shutdown();
        sub_ = it_->subscribe(input_, 1, &Rectangle::handleInput, this);
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
        cv_ptr = cv_bridge::toCvCopy(msg);
      } catch(cv_bridge::Exception &e) {
        NODELET_ERROR_STREAM("cv_bridge exception: " << e.what());
      }

      cv::rectangle(cv_ptr->image, cv::Point(x_, y_), cv::Point(x_ + width_, y_ + height_), cv::Scalar(0, 0, 0), CV_FILLED);

      pub_.publish(cv_ptr->toImageMsg());
    }

  private:
    virtual void initialize() {
      it_ = boost::make_shared<image_transport::ImageTransport>(nh);
    }

    boost::shared_ptr<image_transport::ImageTransport> it_;

    image_transport::Publisher pub_;
    image_transport::Subscriber sub_;

    int x_, y_, width_, height_;
    std::string input_, output_;
  };

  PLUGINLIB_EXPORT_CLASS(capra_filters::Rectangle, nodelet::Nodelet);
}
