#include <ros/ros.h>
#include <nodelet/nodelet.h>
#include <pluginlib/class_list_macros.h>
#include <dynamic_reconfigure/server.h>
#include <capra_filters/blur_filterConfig.h>

PLUGINLIB_EXPORT_CLASS(capra_filters::BlurFilter, nodelet::Nodelet);

namespace capra_filters {

  class BlurFilter : public nodelet::Nodelet {

  public:
    BlurFilter() {
    }

    void callback(capra_filters::blur_filterConfig& config, uint32_t level) {
      ksize = config.ksize;

      NODELET_INFO_STREAM("ksize = " << ksize);
    }

  private:
    virtual void onInit() {
      NODELET_INFO("My debug statement");

      ros::NodeHandle &pnh = getMTPrivateNodeHandle();

      _srv = boost::make_shared<dynamic_reconfigure::Server<capra_filters::blur_filterConfig> >(pnh);

      dynamic_reconfigure::Server<capra_filters::blur_filterConfig>::CallbackType f;
      f = boost::bind(&BlurFilter::callback, this, _1, _2);

      _srv->setCallback(f);
    }

    int ksize;
    boost::shared_ptr<dynamic_reconfigure::Server<capra_filters::blur_filterConfig> > _srv;
  };
}
