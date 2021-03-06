﻿// -*- C++ -*-
/*!
 * @file  measure_cppTest.cpp
 * @brief measurement of the processing time
 * @date $Date$
 *
 * @author n-miyamoto@aist.go.jp
 *
 * MIT
 *
 * $Id$
 */

#include "measure_cppTest.h"

// Module specification
// <rtc-template block="module_spec">
static const char* measure_cpp_spec[] =
  {
    "implementation_id", "measure_cppTest",
    "type_name",         "measure_cppTest",
    "description",       "measurement of the processing time",
    "version",           "1.0.0",
    "vendor",            "Nobuhiko Miyamoto",
    "category",          "Sample",
    "activity_type",     "PERIODIC",
    "kind",              "DataFlowComponent",
    "max_instance",      "1",
    "language",          "C++",
    "lang_type",         "compile",
    // Configuration variables
    "conf.default.ior_str", "0",
    "conf.default.exe_enable", "0",
    "conf.default.max_count", "1000",

    // Widget
    "conf.__widget__.ior_str", "text",
    "conf.__widget__.exe_enable", "radio",
    "conf.__widget__.max_count", "text",
    // Constraints
    "conf.__constraints__.exe_enable", "(0,1)",

    "conf.__type__.ior_str", "string",
    "conf.__type__.exe_enable", "int",
    "conf.__type__.max_count", "int",

    ""
  };
// </rtc-template>

/*!
 * @brief constructor
 * @param manager Maneger Object
 */
measure_cppTest::measure_cppTest(RTC::Manager* manager)
    // <rtc-template block="initializer">
  : RTC::DataFlowComponentBase(manager),
    m_servicePort("service")

    // </rtc-template>
{
}

/*!
 * @brief destructor
 */
measure_cppTest::~measure_cppTest()
{
}



RTC::ReturnCode_t measure_cppTest::onInitialize()
{
  // Registration: InPort/OutPort/Service
  // <rtc-template block="registration">
  // Set InPort buffers
  
  // Set OutPort buffer
  
  // Set service provider to Ports
  m_servicePort.registerProvider("interface", "Echo", m_interface);
  
  // Set service consumers to Ports
  
  // Set CORBA Service Ports
  addPort(m_servicePort);
  
  // </rtc-template>

  // <rtc-template block="bind_config">
  // Bind variables and configuration variable
  bindParameter("ior_str", m_ior_str, "0");
  bindParameter("exe_enable", m_exe_enable, "0");
  bindParameter("max_count", m_max_count, "1000");
  // </rtc-template>
  
  return RTC::RTC_OK;
}

/*
RTC::ReturnCode_t measure_cppTest::onFinalize()
{
  return RTC::RTC_OK;
}
*/

/*
RTC::ReturnCode_t measure_cppTest::onStartup(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}
*/

/*
RTC::ReturnCode_t measure_cppTest::onShutdown(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}
*/


RTC::ReturnCode_t measure_cppTest::onActivated(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}


RTC::ReturnCode_t measure_cppTest::onDeactivated(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}


RTC::ReturnCode_t measure_cppTest::onExecute(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}

/*
RTC::ReturnCode_t measure_cppTest::onAborting(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}
*/

/*
RTC::ReturnCode_t measure_cppTest::onError(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}
*/

/*
RTC::ReturnCode_t measure_cppTest::onReset(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}
*/

/*
RTC::ReturnCode_t measure_cppTest::onStateUpdate(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}
*/

/*
RTC::ReturnCode_t measure_cppTest::onRateChanged(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}
*/



extern "C"
{
 
  void measure_cppTestInit(RTC::Manager* manager)
  {
    coil::Properties profile(measure_cpp_spec);
    manager->registerFactory(profile,
                             RTC::Create<measure_cppTest>,
                             RTC::Delete<measure_cppTest>);
  }
  
};


