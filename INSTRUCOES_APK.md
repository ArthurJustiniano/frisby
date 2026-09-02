# Como Gerar e Baixar o Arquivo APK do Frisby

O seu aplicativo **Frisby** foi totalmente estruturado em **código Flutter nativo (Dart)** na pasta `lib/`, com suporte a Material 3, temas Claro e Elegant Dark, persistência de dados e cálculo ponderado.

Abaixo estão os dois métodos para você obter o arquivo `.apk` final para instalar no seu celular Android:

---

## Método 1: Gerar o APK na Nuvem (Recomendado - Sem instalar nada no PC)

Como compilar Android exige o Android Studio e Flutter SDK (que ocupam mais de 10GB de espaço), nós configuramos o **GitHub Actions** (`.github/workflows/build_apk.yml`). Ele compila o seu APK de forma 100% gratuita nos servidores da nuvem.

### Passo a passo:
1. Crie um repositório no seu [GitHub](https://github.com/new) (ex: `frisby-app`).
2. Envie os arquivos desta pasta `frisby` para o seu repositório:
   ```bash
   git init
   git add .
   git commit -m "Meu app Flutter Frisby"
   git branch -M main
   git remote add origin https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git
   git push -u origin main
   ```
3. Acesse o seu repositório no navegador e clique na aba **Actions**.
4. Você verá a tarefa **"Build Flutter APK"** rodando automaticamente.
5. Quando o ícone verde aparecer (após 2 a 3 minutos), clique na execução e, na seção **Artifacts**, clique em **`frisby-release-apk`** para baixar o arquivo `.apk` diretamente para o seu computador ou celular!

---

## Método 2: Compilar Localmente no Windows

Se você preferir compilar diretamente no seu computador:

### 1. Instalar o Flutter SDK
Abra o PowerShell como Administrador e execute:
```powershell
winget install Google.Flutter
```
Reinicie o terminal para atualizar as variáveis de ambiente.

### 2. Instalar o Android Studio
1. Baixe o [Android Studio](https://developer.android.com/studio).
2. Durante a instalação, certifique-se de instalar o **Android SDK** e **Android SDK Command-line Tools**.
3. Aceite as licenças do Android no terminal:
   ```powershell
   flutter doctor --android-licenses
   ```

### 3. Gerar o APK
No terminal, dentro da pasta `frisby`, execute:
```powershell
flutter pub get
flutter build apk --release
```

O arquivo gerado estará pronto em:
`frisby/build/app/outputs/flutter-apk/app-release.apk`
Basta copiar esse arquivo para o seu celular Android e instalar!
