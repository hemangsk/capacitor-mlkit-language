package dev.hemang.mlkit_language.Language;

public class LanguageIdentificationException extends Exception {
    public static final String INVALID_TEXT = "`text` field is empty.";

    public LanguageIdentificationException(String errorMessage) {
        super(errorMessage);
    }
}
