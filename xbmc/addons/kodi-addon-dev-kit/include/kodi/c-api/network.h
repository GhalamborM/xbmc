/*
 *  Copyright (C) 2005-2018 Team Kodi
 *  This file is part of Kodi - https://kodi.tv
 *
 *  SPDX-License-Identifier: GPL-2.0-or-later
 *  See LICENSES/README.md for more information.
 */

#pragma once

#include "../AddonBase.h"

#ifdef __cplusplus
extern "C"
{
#endif /* __cplusplus */

  /*
   * For interface between add-on and kodi.
   *
   * This structure defines the addresses of functions stored inside Kodi which
   * are then available for the add-on to call
   *
   * All function pointers there are used by the C++ interface functions below.
   * You find the set of them on xbmc/addons/interfaces/General.cpp
   *
   * Note: For add-on development itself this is not needed
   */
  typedef struct AddonToKodiFuncTable_kodi_network
  {
    bool (*wake_on_lan)(KODI_HANDLE kodiBase, const char* mac);
    char* (*get_ip_address)(KODI_HANDLE kodiBase);
    char* (*dns_lookup)(KODI_HANDLE kodiBase, const char* url, bool* ret);
    char* (*url_encode)(KODI_HANDLE kodiBase, const char* url);
    char* (*get_hostname)(KODI_HANDLE kodiBase);
    bool (*is_local_host)(KODI_HANDLE kodiBase, const char* hostname);
    bool (*is_host_on_lan)(void* kodiBase, const char* hostname, bool offLineCheck);
  } AddonToKodiFuncTable_kodi_network;

#ifdef __cplusplus
} /* extern "C" */
#endif /* __cplusplus */