#ifndef CAPRA_FILTERS_FILTER_H
#define CAPRA_FILTERS_FILTER_H

#include <nodelet/nodelet.h>
#include <ros/ros.h>
#include <pluginlib/class_list_macros.h>
#include <dynamic_reconfigure/server.h>

namespace capra_filters {

  template<typename Config>
  class Filter : public nodelet::Nodelet {
  public:
    Filter() {
    }

    virtual void configure(Config &config, uint32_t level) = 0;

  protected:
    ros::NodeHandle nh;
    ros::NodeHandle pnh;

  private:

    virtual void initialize() = 0;
    virtual void onInit() {
      typedef typename dynamic_reconfigure::Server<Config>::CallbackType ServerCallbackType;

      nh = getMTNodeHandle();
      pnh = getMTPrivateNodeHandle();

      srv_ = boost::make_shared<dynamic_reconfigure::Server<Config> >(pnh);

      ServerCallbackType f = boost::bind(&Filter::configure_callback, this, _1, _2);

      initialize();

      // ensure callback is only invoked after the filter is initialized
      srv_->setCallback(f);
    }

    void configure_callback(Config &config, uint32_t level) {
      configure(config, level);
    }

    boost::shared_ptr<dynamic_reconfigure::Server<Config> > srv_;
  };

}

#endif
