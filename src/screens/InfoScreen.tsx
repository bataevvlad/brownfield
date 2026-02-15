import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  SafeAreaView,
  TouchableOpacity,
  Platform,
  NativeModules,
} from 'react-native';

const InfoScreen: React.FC = () => {
  const handleClose = () => {
    // Use native module to dismiss the React Native view
    if (Platform.OS === 'ios') {
      NativeModules.ReactNativeBridge?.dismiss?.();
    } else {
      NativeModules.ReactNativeBridge?.dismiss?.();
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <TouchableOpacity onPress={handleClose} style={styles.closeButton}>
          <Text style={styles.closeButtonText}>← Back</Text>
        </TouchableOpacity>
        <Text style={styles.headerTitle}>Info</Text>
        <View style={styles.placeholder} />
      </View>

      <View style={styles.content}>
        <View style={styles.appIconContainer}>
          <View style={styles.appIcon}>
            <Text style={styles.appIconText}>🧮</Text>
          </View>
        </View>

        <Text style={styles.appName}>Calculator</Text>
        <Text style={styles.appVersion}>Version 1.0.0</Text>

        <View style={styles.badge}>
          <Text style={styles.badgeText}>⚛️ Powered by React Native</Text>
        </View>

        <View style={styles.infoSection}>
          <Text style={styles.sectionTitle}>About</Text>
          <Text style={styles.sectionText}>
            This is a demonstration of React Native brownfield integration.
            The calculator UI is built with native code (Swift for iOS, Kotlin for Android),
            while this Info screen is built with React Native.
          </Text>
        </View>

        <View style={styles.infoSection}>
          <Text style={styles.sectionTitle}>Technology Stack</Text>
          <View style={styles.techStack}>
            <View style={styles.techItem}>
              <Text style={styles.techLabel}>iOS</Text>
              <Text style={styles.techValue}>Swift + UIKit</Text>
            </View>
            <View style={styles.techItem}>
              <Text style={styles.techLabel}>Android</Text>
              <Text style={styles.techValue}>Kotlin + XML</Text>
            </View>
            <View style={styles.techItem}>
              <Text style={styles.techLabel}>Info Screen</Text>
              <Text style={styles.techValue}>React Native</Text>
            </View>
          </View>
        </View>
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#1C1C1E',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 16,
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#38383A',
  },
  closeButton: {
    padding: 8,
  },
  closeButtonText: {
    color: '#FF9500',
    fontSize: 17,
  },
  headerTitle: {
    color: '#FFFFFF',
    fontSize: 17,
    fontWeight: '600',
  },
  placeholder: {
    width: 60,
  },
  content: {
    flex: 1,
    padding: 24,
    alignItems: 'center',
  },
  appIconContainer: {
    marginTop: 20,
    marginBottom: 16,
  },
  appIcon: {
    width: 100,
    height: 100,
    borderRadius: 22,
    backgroundColor: '#2C2C2E',
    justifyContent: 'center',
    alignItems: 'center',
  },
  appIconText: {
    fontSize: 50,
  },
  appName: {
    color: '#FFFFFF',
    fontSize: 28,
    fontWeight: '700',
    marginBottom: 4,
  },
  appVersion: {
    color: '#8E8E93',
    fontSize: 15,
    marginBottom: 20,
  },
  badge: {
    backgroundColor: '#2C2C2E',
    paddingHorizontal: 16,
    paddingVertical: 10,
    borderRadius: 20,
    marginBottom: 32,
  },
  badgeText: {
    color: '#61DAFB',
    fontSize: 14,
    fontWeight: '600',
  },
  infoSection: {
    width: '100%',
    marginBottom: 24,
  },
  sectionTitle: {
    color: '#FF9500',
    fontSize: 13,
    fontWeight: '600',
    textTransform: 'uppercase',
    letterSpacing: 1,
    marginBottom: 12,
  },
  sectionText: {
    color: '#FFFFFF',
    fontSize: 15,
    lineHeight: 22,
  },
  techStack: {
    backgroundColor: '#2C2C2E',
    borderRadius: 12,
    overflow: 'hidden',
  },
  techItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingHorizontal: 16,
    paddingVertical: 14,
    borderBottomWidth: 1,
    borderBottomColor: '#38383A',
  },
  techLabel: {
    color: '#8E8E93',
    fontSize: 15,
  },
  techValue: {
    color: '#FFFFFF',
    fontSize: 15,
  },
  footer: {
    marginTop: 'auto',
    paddingBottom: 20,
  },
  footerText: {
    color: '#8E8E93',
    fontSize: 12,
  },
});

export default InfoScreen;
