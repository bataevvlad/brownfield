plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "com.brownfield.calculator"
    compileSdk = 35

    defaultConfig {
        applicationId = "com.brownfield.calculator"
        minSdk = 26
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"

        buildConfigField("boolean", "IS_NEW_ARCHITECTURE_ENABLED", "false")
        buildConfigField("boolean", "IS_HERMES_ENABLED", "true")
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    buildFeatures {
        viewBinding = true
        buildConfig = true
    }

    packaging {
        jniLibs {
            useLegacyPackaging = true
        }
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.12.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.11.0")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")

    // React Native dependencies with explicit version
    implementation("com.facebook.react:react-android:0.76.0")
    implementation("com.facebook.react:hermes-android:0.76.0")
}

// Bundle React Native JS for debug builds
tasks.register<Exec>("bundleReactNative") {
    val rootDir = file("../../../../")
    workingDir = rootDir

    val assetsDir = file("${projectDir}/src/main/assets")
    doFirst {
        assetsDir.mkdirs()
    }

    commandLine(
        "npx", "react-native", "bundle",
        "--platform", "android",
        "--dev", "false",
        "--entry-file", "index.js",
        "--bundle-output", "${assetsDir}/index.android.bundle",
        "--assets-dest", "${projectDir}/src/main/res"
    )
}

tasks.named("preBuild") {
    dependsOn("bundleReactNative")
}
