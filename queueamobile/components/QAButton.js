import React, { Component } from 'react';
import { AppRegistry, StyleSheet, TouchableHighlight, View, Text } from 'react-native';

export default class QAButton extends Component {
  render() {
    return (
        <TouchableHighlight 
          disabled={this.props.disabled}
          onPress={this.props.onPress} underlayColor='white'>
            <View style={[styles.button, this.props.styleOverride, this.props.disabled ? styles.disabledBtn : styles.enabledBtn]}>
                <Text 
                  style={[styles.title, this.props.disabled ? styles.disabledTitle : styles.enabledTitle]}>
                    {this.props.title}
                </Text>
            </View>
        </TouchableHighlight>
    );
  }
}

const styles = StyleSheet.create({
    button: {
      margin: 20,
      minWidth: 100,
      paddingLeft: 20,
      paddingRight: 20,
      alignItems: 'center',
      justifyContent: 'center',
      backgroundColor: '#16966A',
      borderColor: 'rgba(0,0,0,.1)',
      borderRadius: 4,
      height: 44,
    },
    enabledBtn: {
      backgroundColor: '#16966A',
      borderWidth: 0
    },
    disabledBtn: {
      backgroundColor: '#00000000',
      borderWidth: 2
    },
    title: {
      fontSize: 17,
      fontWeight: 'bold'
    },
    enabledTitle: {
      color: 'white'
    },
    disabledTitle: {
      color: 'rgba(0,0,0,.2)'
    }
  })

AppRegistry.registerComponent('QAButton', () => QAButton);
