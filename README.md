# TP4 : Analyse statique d'APK Android - UnCrackable Level 1

## 📌 Présentation
Ce dépôt contient les travaux réalisés lors du **TP4 : Sécurité / Analyse d'APK Android**. L'objectif principal était de mener une analyse statique approfondie de l'application `UnCrackable Level 1` de l'OWASP MAS pour comprendre sa structure, identifier des vulnérabilités de configuration et extraire des secrets enfouis dans le code sans jamais exécuter l'application.

**Auteur :** Amira Ezbiri 
**Année Universitaire :** 2025-2026

---

## 🛠️ Outils et Environnement
L'analyse a été effectuée dans un environnement Windows utilisant **PowerShell** pour l'automatisation et les outils de rétro-ingénierie suivants :
**JADX GUI :** Pour la décompilation globale, l'examen du manifeste et des ressources.
**dex2jar :** Pour convertir les fichiers `.dex` en fichiers `.jar`.
**JD-GUI :** Pour une lecture alternative et rapide du code Java décompilé.

---

## 🔍 Méthodologie et Observations

### 1. Préparation et Intégrité
Le workspace a été configuré via script pour garantir la traçabilité. L'intégrité de l'APK a été vérifiée par son empreinte **SHA-256** :
**Hash :** `1DA8BF57D266109F9A07CB18F7111A1975CE01F1908909148CD3AE3DBEF96F21`.
**Taille :** ~65 Ko.

### 2. Analyse du Manifeste (`AndroidManifest.xml`)
Des informations critiques sur la configuration de l'application ont été extraites:
**Package :** `owasp.mstg.uncrackable1`.
**Cible SDK :** 28 (Android 9.0).
**Vulnérabilité de configuration :** L'attribut `android:allowBackup="true"` est présent, ce qui permettrait l'extraction de données via ADB.

### 3. Extraction de Secrets et Logique Interne
La recherche globale dans le code décompilé a révélé des éléments de sécurité sensibles:
**Secret Hardcodé :** La chaîne `"This is the correct secret"` a été trouvée dans le bytecode.
**Cryptographie :** Utilisation de `AES/ECB/PKCS7Padding` via la classe `SecretKeySpec`.
**Indices de Débogage :** Présence de messages `"App is debuggable!"` et de logs techniques via `Log.d("CodeCheck", ...)`.
**Anti-Root :** Une vérification de l'environnement est effectuée via la recherche de `"test-keys"`.

---

## 📊 Comparaison des Décompilateurs
| Critère | JADX GUI | JD-GUI |
| :--- | :--- | :--- |
| **Navigation** | Très pratique (Manifeste, ressources et classes regroupés)  | Centré principalement sur le code Java  |
| **Recherche** | Recherche globale très efficace |Plus limitée |
| **Ressources** | Directement visibles et déparsées  |Non supportées nativement |

---

## 💡 Conclusion
Ce TP démontre qu'une application mal protégée livre facilement ses secrets (logique métier, clés, flags de debug) à travers une simple analyse statique. Pour sécuriser une application, il est impératif d'utiliser l'obfuscation et de ne jamais stocker de secrets en clair dans le code source.
