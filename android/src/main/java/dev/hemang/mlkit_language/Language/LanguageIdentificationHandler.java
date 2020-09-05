package dev.hemang.mlkit_language.Language;

import androidx.annotation.NonNull;

import com.getcapacitor.JSArray;
import com.getcapacitor.JSObject;
import com.getcapacitor.PluginCall;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.mlkit.nl.languageid.IdentifiedLanguage;
import com.google.mlkit.nl.languageid.LanguageIdentification;
import com.google.mlkit.nl.languageid.LanguageIdentificationOptions;
import com.google.mlkit.nl.languageid.LanguageIdentifier;

import java.util.List;

public class LanguageIdentificationHandler {

    /**
     * pluginCall holds the capacitor's PluginCall object containing the params passed to plugin.
     * This helps us to send a response on success and failure to the typescript middleware.
     */
    PluginCall pluginCall;

    /**
     * To hold MLKit's language identification client
     */
    LanguageIdentifier languageIdentifier;
    LanguageIdentificationOptions languageIdentificationOptions;

    // Text whose language is to be identified.
    String text;

    // Constants
    public static final String TEXT_KEY = "text";
    public static final String LANGUAGE_IDENTIFICATION_OPTIONS_KEY = "languageIdentificationOptions";
    public static final String LIO_CONFIDENCE_KEY = "confidenceThreshold";

    public static final String RESULT_LANGUAGE_KEY = "languageCode";
    public static final String RESULT_CONFIDENCE_KEY = "confidence";
    public static final String RESULT_KEY = "possibleLanguages";

    /**
     * @param call Plugin call originally passed to the Plugin method
     */
    public LanguageIdentificationHandler(PluginCall call) {
        pluginCall = call;
        setText();
        setLanguageIdentificationOptions();
        setLanguageIdentifier();
    }

    /**
     * Sets language identification option with a confidence threshold if passed.
     * Otherwise the default confidence threshold depending on the scenario is used.
     */
    public void setLanguageIdentificationOptions() {
        JSObject languageIdentificationOptionsJSON = pluginCall.getObject(LANGUAGE_IDENTIFICATION_OPTIONS_KEY, new JSObject());
        String confidenceThreshold = languageIdentificationOptionsJSON.getString(LIO_CONFIDENCE_KEY, "");

        // Use parseFloat to convert confidenceThreshold into a float value
        if (confidenceThreshold.length() > 0) {
            languageIdentificationOptions = new LanguageIdentificationOptions.Builder()
                    .setConfidenceThreshold(Float.parseFloat(confidenceThreshold))
                    .build();

        } else {
            languageIdentificationOptions = new LanguageIdentificationOptions.Builder()
                    .build();
        }
    }

    public void setLanguageIdentifier() {
        languageIdentifier = LanguageIdentification.getClient(languageIdentificationOptions);
    }

    public void setText() {
        text = pluginCall.getString(TEXT_KEY, "");
    }

    public Boolean isTextValid() {
        if (text.length() == 0) {
            return false;
        }
        return true;
    }

    public void identifyLanguage() throws LanguageIdentificationException {

        if (!isTextValid()) {
            throw new LanguageIdentificationException(LanguageIdentificationException.INVALID_TEXT);
        }

        languageIdentifier.identifyLanguage(text)
                .addOnSuccessListener(new OnSuccessListener<String>() {
                    @Override
                    public void onSuccess(String s) {
                        JSObject result = new JSObject();
                        result.put(RESULT_LANGUAGE_KEY, s);
                        pluginCall.success(result);
                    }
                })
                .addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        pluginCall.error(e.getMessage());
                    }
                });
    }

    public void identifyPossibleLanguages() throws LanguageIdentificationException {

        if (!isTextValid()) {
            throw new LanguageIdentificationException(LanguageIdentificationException.INVALID_TEXT);
        }

        languageIdentifier.identifyPossibleLanguages(text)
                .addOnSuccessListener(new OnSuccessListener<List<IdentifiedLanguage>>() {
                    @Override
                    public void onSuccess(List<IdentifiedLanguage> identifiedLanguages) {

                        JSObject result = new JSObject();

                        JSArray listOfLanguageObjects = new JSArray();
                        for (IdentifiedLanguage language:
                                identifiedLanguages) {
                            JSObject langObject = new JSObject();
                            langObject.put(RESULT_CONFIDENCE_KEY, language.getConfidence());
                            langObject.put(RESULT_LANGUAGE_KEY, language.getLanguageTag());
                            listOfLanguageObjects.put(langObject);
                        }

                        result.put(RESULT_KEY, listOfLanguageObjects);

                        pluginCall.success(result);
                    }
                })
                .addOnFailureListener(new OnFailureListener() {
                    @Override
                    public void onFailure(@NonNull Exception e) {
                        pluginCall.error(e.getMessage());
                    }
                });
    }
}
