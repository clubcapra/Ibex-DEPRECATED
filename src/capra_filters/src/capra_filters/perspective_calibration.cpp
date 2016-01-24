#include <capra_filters/filter.h>

#include <capra_filters/perspective_calibrationConfig.h>
#include <cv_bridge/cv_bridge.h>
#include <image_transport/image_transport.h>
#include <opencv2/imgproc/imgproc.hpp>

namespace capra_filters {

  class PerspectiveCalibration : public capra_filters::Filter<capra_filters::perspective_calibrationConfig> {

  public:
    PerspectiveCalibration() {
    }

    virtual void configure(capra_filters::perspective_calibrationConfig& config, uint32_t level) {
      top_left_x_ = config.top_left_x;
      top_left_y_ = config.top_left_y;
      top_right_x_ = config.top_right_x;
      top_right_y_ = config.top_right_y;
      bottom_left_x_ = config.bottom_left_x;
      bottom_left_y_ = config.bottom_left_y;
      bottom_right_x_ = config.bottom_right_x;
      bottom_right_y_ = config.bottom_right_y;
      translation_x_ = config.translation_x;
      translation_y_ = config.translation_y;
      zoom_ = config.zoom;

      if(config.input != input_) {
        input_ = config.input;
        sub_.shutdown();
        sub_ = it_->subscribe(input_, 1, &PerspectiveCalibration::handleInput, this);
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

      cv_ptr->image = transform(perspective(cv_ptr->image));

      pub_.publish(cv_ptr->toImageMsg());
    }


    cv::Mat perspective(cv::Mat image) {
      const double w = image.cols;
      const double h = image.rows;

      cv::Point2f src_vertices[4];
      src_vertices[0] = cv::Point(0,0);
      src_vertices[1] = cv::Point(0,h);
      src_vertices[2] = cv::Point(w,0);
      src_vertices[3] = cv::Point(w,h);

      cv::Point2f dst_vertices[4];
      dst_vertices[0] = cv::Point(top_left_x_, top_left_y_);
      dst_vertices[1] = cv::Point(bottom_left_x_, bottom_left_y_);
      dst_vertices[2] = cv::Point(top_right_x_, top_right_y_);
      dst_vertices[3] = cv::Point(bottom_right_x_, bottom_right_y_);

      cv::Mat warpMatrix = cv::getPerspectiveTransform(src_vertices, dst_vertices);

      cv::Mat imageWarped;
      cv::warpPerspective(image, imageWarped, warpMatrix, imageWarped.size());

      return imageWarped;
    }

    cv::Mat transform(cv::Mat image){
      using namespace cv;

      const double w = image.cols;
      const double h = image.rows;

      // Projection 2D -> 3D matrix
      Mat A1 = (Mat_<double>(4,3) <<
		1, 0, -w/2,
		0, 1, -h/2,
		0, 0,    0,
		0, 0,    1);

      // Translation matrix on the Z axis
      Mat T = (Mat_<double>(4, 4) <<
               1, 0, 0, translation_x_,
               0, 1, 0, translation_y_,
               0, 0, 1, zoom_/100.0f,
               0, 0, 0, 1);

      const double f = 1;
      // Camera Intrisecs matrix 3D -> 2D
      Mat A2 = (Mat_<double>(3,4) <<
		f, 0, w/2, 0,
		0, f, h/2, 0,
		0, 0,   1, 0);

      Mat transfo = A2 * (T * (A1));

      Mat destination;

      warpPerspective(image, destination, transfo, image.size(), INTER_CUBIC | WARP_INVERSE_MAP);

      return destination;
    }

  private:
    virtual void initialize() {
      it_ = boost::make_shared<image_transport::ImageTransport>(nh);
    }

    boost::shared_ptr<image_transport::ImageTransport> it_;

    image_transport::Publisher pub_;
    image_transport::Subscriber sub_;

    int top_left_x_, top_left_y_, top_right_x_, top_right_y_,
      bottom_left_x_, bottom_left_y_, bottom_right_x_, bottom_right_y_,
      translation_x_, translation_y_, zoom_;

    std::string input_, output_;
  };

  PLUGINLIB_EXPORT_CLASS(capra_filters::PerspectiveCalibration, nodelet::Nodelet);
}
