// -*-C++-*-
/*!
 * @file  echoSVC_impl.h
 * @brief Service implementation header of echo.idl
 *
 * @author n-miyamoto@aist.go.jp
 *
 * MIT
 *
 */

#include "echoSkel.h"

#ifndef ECHOSVC_IMPL_H
#define ECHOSVC_IMPL_H
 
/*!
 * @class EchoSVC_impl
 * Example class implementing IDL interface Echo
 */
class EchoSVC_impl
 : public virtual POA_Echo,
   public virtual PortableServer::RefCountServantBase
{
 private:
   // Make sure all instances are built on the heap by making the
   // destructor non-public
   //virtual ~EchoSVC_impl();

 public:
  /*!
   * @brief standard constructor
   */
   EchoSVC_impl();
  /*!
   * @brief destructor
   */
   virtual ~EchoSVC_impl();

   // attributes and operations
   char* echoString(const char* mesg);

};



#endif // ECHOSVC_IMPL_H


