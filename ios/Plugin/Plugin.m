#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(MLKitLanguage, "MLKitLanguage",
           CAP_PLUGIN_METHOD(NLLIdentifyLanguage, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(NLLIdentifyPossibleLanguages, CAPPluginReturnPromise);
)
