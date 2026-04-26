# TP4 : Analyse statique d'APK Android - UnCrackable Level 1

## 📌 Présentation
[cite_start]Ce dépôt contient les travaux réalisés lors du **TP4 : Sécurité / Analyse d'APK Android**[cite: 4]. [cite_start]L'objectif principal était de mener une analyse statique approfondie de l'application `UnCrackable Level 1` de l'OWASP MAS [cite: 3] [cite_start]pour comprendre sa structure, identifier des vulnérabilités de configuration et extraire des secrets enfouis dans le code sans jamais exécuter l'application[cite: 14, 15].

[cite_start]**Auteur :** Amira Ezbiri [cite: 4]  
[cite_start]**Année Universitaire :** 2025-2026 [cite: 5]

---

## 🛠️ Outils et Environnement
[cite_start]L'analyse a été effectuée dans un environnement Windows utilisant **PowerShell** pour l'automatisation [cite: 20] et les outils de rétro-ingénierie suivants :
* [cite_start]**JADX GUI :** Pour la décompilation globale, l'examen du manifeste et des ressources[cite: 4, 84].
* [cite_start]**dex2jar :** Pour convertir les fichiers `.dex` en fichiers `.jar`[cite: 4, 285].
* [cite_start]**JD-GUI :** Pour une lecture alternative et rapide du code Java décompilé[cite: 4, 286].

---

## 🔍 Méthodologie et Observations

### 1. Préparation et Intégrité
[cite_start]Le workspace a été configuré via script pour garantir la traçabilité[cite: 17]. L'intégrité de l'APK a été vérifiée par son empreinte **SHA-256** :
* [cite_start]**Hash :** `1DA8BF57D266109F9A07CB18F7111A1975CE01F1908909148CD3AE3DBEF96F21`[cite: 73].
* [cite_start]**Taille :** ~65 Ko[cite: 34, 82].

### 2. Analyse du Manifeste (`AndroidManifest.xml`)
[cite_start]Des informations critiques sur la configuration de l'application ont été extraites[cite: 172]:
* [cite_start]**Package :** `owasp.mstg.uncrackable1`[cite: 172].
* [cite_start]**Cible SDK :** 28 (Android 9.0)[cite: 172].
* [cite_start]**Vulnérabilité de configuration :** L'attribut `android:allowBackup="true"` est présent, ce qui permettrait l'extraction de données via ADB[cite: 172, 173].

### 3. Extraction de Secrets et Logique Interne
[cite_start]La recherche globale dans le code décompilé a révélé des éléments de sécurité sensibles[cite: 177, 281]:
* [cite_start]**Secret Hardcodé :** La chaîne `"This is the correct secret"` a été trouvée dans le bytecode[cite: 205, 281].
* [cite_start]**Cryptographie :** Utilisation de `AES/ECB/PKCS7Padding` via la classe `SecretKeySpec`[cite: 203, 281].
* [cite_start]**Indices de Débogage :** Présence de messages `"App is debuggable!"` et de logs techniques via `Log.d("CodeCheck", ...)`[cite: 227, 246, 281].
* [cite_start]**Anti-Root :** Une vérification de l'environnement est effectuée via la recherche de `"test-keys"`[cite: 272, 281].

---

## 📊 Comparaison des Décompilateurs
| Critère | JADX GUI | JD-GUI |
| :--- | :--- | :--- |
| **Navigation** | [cite_start]Très pratique (Manifeste, ressources et classes regroupés) [cite: 314] | [cite_start]Centré principalement sur le code Java [cite: 314] |
| **Recherche** | [cite_start]Recherche globale très efficace [cite: 314] | [cite_start]Plus limitée [cite: 314] |
| **Ressources** | [cite_start]Directement visibles et déparsées [cite: 314] | [cite_start]Non supportées nativement [cite: 314] |

---

## 💡 Conclusion
[cite_start]Ce TP démontre qu'une application mal protégée livre facilement ses secrets (logique métier, clés, flags de debug) à travers une simple analyse statique[cite: 319, 320]. [cite_start]Pour sécuriser une application, il est impératif d'utiliser l'obfuscation et de ne jamais stocker de secrets en clair dans le code source[cite: 283, 320].
