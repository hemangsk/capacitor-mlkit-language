package dev.hemang.mlkit_language;

import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;

import dev.hemang.mlkit_language.Language.LanguageIdentificationException;
import dev.hemang.mlkit_language.Language.LanguageIdentificationHandler;

@NativePlugin
public class MLKitLanguage extends Plugin {

    @PluginMethod()
    public void NLLIdentifyLanguage(PluginCall call) {
        LanguageIdentificationHandler languageIDHandler = new LanguageIdentificationHandler(call);

        try {
            languageIDHandler.identifyLanguage();
        } catch (LanguageIdentificationException e) {
            call.error(e.getMessage());
        }
    }

    @PluginMethod()
    public void NLLIdentifyPossibleLanguages(PluginCall call) {
        LanguageIdentificationHandler languageIDHandler = new LanguageIdentificationHandler(call);
        try {
            languageIDHandler.identifyPossibleLanguages();
        } catch (LanguageIdentificationException e) {
            call.error(e.getMessage());
        }
    }
}
