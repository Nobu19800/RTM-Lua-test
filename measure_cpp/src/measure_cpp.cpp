// -*- C++ -*-
/*!
 * @file  measure_cpp.cpp
 * @brief measurement of the processing time
 * @date $Date$
 *
 * @author n-miyamoto@aist.go.jp
 *
 * MIT
 *
 * $Id$
 */

#include "measure_cpp.h"
#include <random>

// Module specification
// <rtc-template block="module_spec">
static const char* measure_cpp_spec[] =
  {
    "implementation_id", "measure_cpp",
    "type_name",         "measure_cpp",
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
measure_cpp::measure_cpp(RTC::Manager* manager)
    // <rtc-template block="initializer">
  : RTC::DataFlowComponentBase(manager)

    // </rtc-template>
{
}

/*!
 * @brief destructor
 */
measure_cpp::~measure_cpp()
{
}



RTC::ReturnCode_t measure_cpp::onInitialize()
{
  // Registration: InPort/OutPort/Service
  // <rtc-template block="registration">
  // Set InPort buffers
  
  // Set OutPort buffer
  
  // Set service provider to Ports
  
  // Set service consumers to Ports

  
  // Set CORBA Service Ports

  
  // </rtc-template>

  // <rtc-template block="bind_config">
  // Bind variables and configuration variable
  bindParameter("ior_str", m_ior_str, "0");
  bindParameter("exe_enable", m_exe_enable, "0");
  bindParameter("max_count", m_max_count, "1000");
  // </rtc-template>

  if (m_ior_str.length() > 10)
  {
	  CORBA::ORB_var orb = ::RTC::Manager::instance().getORB();
	  //std::cout << m_ior_str << std::endl;

	  CORBA::Object_var obj = orb->string_to_object(m_ior_str.c_str());

	  Echo_var var = Echo::_narrow(obj);

	  var->echoString("");
  }
  
  return RTC::RTC_OK;
}

/*
RTC::ReturnCode_t measure_cpp::onFinalize()
{
  return RTC::RTC_OK;
}
*/

/*
RTC::ReturnCode_t measure_cpp::onStartup(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}
*/

/*
RTC::ReturnCode_t measure_cpp::onShutdown(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}
*/


RTC::ReturnCode_t measure_cpp::onActivated(RTC::UniqueId ec_id)
{
	chrs.clear();
	for (int i = 0; i < 10000; i++)
	{
		Charactor chr;
		std::uniform_int_distribution<int> rand100(-1000, 1000);
		std::random_device rnd;
		std::mt19937 mt(rnd());

		chr.pos_x = rand100(mt);

		chr.pos_y = rand100(mt);

		chrs[coil::otos<int>(i)] = chr;
	}

	ofs.open("cpp_test.dat", std::ios_base::app);
	start_time = coil::gettimeofday();
	mesure_count = 0;

  return RTC::RTC_OK;
}


RTC::ReturnCode_t measure_cpp::onDeactivated(RTC::UniqueId ec_id)
{
	coil::TimeValue end_time = coil::gettimeofday();
	ofs << (end_time - start_time) << std::endl;
	ofs.close();
  return RTC::RTC_OK;
}


RTC::ReturnCode_t measure_cpp::onExecute(RTC::UniqueId ec_id)
{
	Charactor player;
	if (m_exe_enable == 1)
	{
		for (std::map<std::string, Charactor>::iterator chr = chrs.begin(); chr != chrs.end(); ++chr)
		{
			Charactor tmp_chr = (*chr).second;
			if (abs(player.pos_x - tmp_chr.pos_x) < (player.width / 2 + tmp_chr.width / 2))
			{
				if (abs(player.pos_y - tmp_chr.pos_y) < (player.height / 2 + tmp_chr.height / 2))
				{
					//std::cout << "hit" << std::endl;
					if (player.pos_x < tmp_chr.pos_x)
					{
						player.pos_x += 1;
					}
					else if (player.pos_x > tmp_chr.pos_x)
					{
						player.pos_x -= 1;
					}

					if (player.pos_y < tmp_chr.pos_y)
					{
						player.pos_y += 1;
					}
					else if (player.pos_y > tmp_chr.pos_y)
					{
						player.pos_y -= 1;
					}


				}
			}
		}
	}
	if (mesure_count > m_max_count)
	{
		return RTC::RTC_ERROR;
	}
	mesure_count++;
  return RTC::RTC_OK;
}

/*
RTC::ReturnCode_t measure_cpp::onAborting(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}
*/

/*
RTC::ReturnCode_t measure_cpp::onError(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}
*/

/*
RTC::ReturnCode_t measure_cpp::onReset(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}
*/

/*
RTC::ReturnCode_t measure_cpp::onStateUpdate(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}
*/

/*
RTC::ReturnCode_t measure_cpp::onRateChanged(RTC::UniqueId ec_id)
{
  return RTC::RTC_OK;
}
*/



extern "C"
{
 
  void measure_cppInit(RTC::Manager* manager)
  {
    coil::Properties profile(measure_cpp_spec);
    manager->registerFactory(profile,
                             RTC::Create<measure_cpp>,
                             RTC::Delete<measure_cpp>);
  }
  
};


