<h1 align="center">Capacitor ML Kit Language ID</h1>
<p align="center">
  Plugin implementing Language Identification on Android & iOS using Google's on-device ML library - ML Kit
</p>

<p align="center">
  <a href="https://github.com/hemangsk/capacitor-mlkit-language/workflows/Test/badge.svg">
    <img src="https://github.com/hemangsk/capacitor-mlkit-language/workflows/Test/badge.svg" alt="Tests" style="max-width:100%;">
  </a>

  <a href="https://github.com/hemangsk/capacitor-mlkit-language/workflows/Build/badge.svg">
    <img src="https://github.com/hemangsk/capacitor-mlkit-language/workflows/Build/badge.svg" alt="Builds" style="max-width:100%;">
  </a>

  
  <a href="https://lbesson.mit-license.org/">
    <img src="https://img.shields.io/badge/License-MIT-blue.svg" />
  </a>
  
  <a href="https://github.com/hemangsk/capacitor-mlkit-language/pulse">
    <img src="https://img.shields.io/badge/Maintained-Yes-green.svg" />
  </a>
</p>

## Why ?

[Google's ML Kit SDK](https://developers.google.com/ml-kit/) helps us to identify the language of a string of text. We can get the string's most likely language as well as a list of all the possible languages alongwith confidence scores. This plugin provides a Typescript API to interact with the native ML Kit libraries on iOS and Android.

## Usage

#### 1. Create a LanguageIdentification client

```typescript
const languageIdentifier: LanguageIdentifier = LanguageIdentification.getClient();
```

#### 2. Identify Language

```typescript
const response = await languageIdentifier.identifyLanguage('This is some english');
```

#### 3. Identify All Possible Languages

```typescript
const response = await languageIdentifier.identifyPossibleLanguages('This is some english');
```

## Reference

[Docs](https://hemangsk.github.io/capacitor-mlkit-language/)
