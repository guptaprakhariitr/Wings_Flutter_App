//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <agora_rtc_engine_plugin.h>
#include <none.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  AgoraRtcEnginePluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("AgoraRtcEnginePlugin"));
  noneRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("none"));
}
