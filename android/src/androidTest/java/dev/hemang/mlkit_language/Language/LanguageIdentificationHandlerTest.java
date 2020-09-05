package dev.hemang.mlkit_language.Language;

import com.getcapacitor.JSObject;
import com.getcapacitor.PluginCall;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class LanguageIdentificationHandlerTest {

    LanguageIdentificationHandler handler;
    PluginCall invalidPluginCall;
    PluginCall validPluginCall;

    @Before
    public void setUp() throws Exception {
        invalidPluginCall = new PluginCall(null,"", "", "random", new JSObject());

        JSObject validTextObject = new JSObject();
        validTextObject.put(LanguageIdentificationHandler.TEXT_KEY, "This is some text");
        validPluginCall = new PluginCall(null,"", "", "random", validTextObject);
    }

    @After
    public void tearDown() throws Exception { }

    @Test
    public void setLanguageIdentificationOptions() {
        handler = new LanguageIdentificationHandler(invalidPluginCall);
        assertNotNull(handler.languageIdentificationOptions);
    }

    @Test
    public void setLanguageIdentifier() {
        handler = new LanguageIdentificationHandler(invalidPluginCall);
        assertNotNull(handler.languageIdentifier);
    }

    @Test
    public void setText() { }

    @Test
    public void isTextValid() {
        handler = new LanguageIdentificationHandler(invalidPluginCall);
        assertFalse(handler.isTextValid());
        handler = new LanguageIdentificationHandler(validPluginCall);
        assertTrue(handler.isTextValid());
    }

    @Test
    public void identifyLanguage() { }

    @Test
    public void identifyPossibleLanguages() { }
}