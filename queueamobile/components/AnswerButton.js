import React, { Component } from 'react';
import { AppRegistry, StyleSheet, TouchableHighlight, View, Text, Image } from 'react-native';

export default class AnswerButton extends Component {
  render() {
    if (this.props.selected) {
        return (
            <TouchableHighlight onPress={this.props.onPress} underlayColor='white'>
                <View style={[styles.container, this.props.selected ? styles.selected : styles.deselected]}>
                    <Text 
                      style={[styles.title, this.props.selected ? styles.selectedTitle : styles.deselectedTitle]}>
                        {this.props.title}
                    </Text>
                    <Image 
                      style={styles.check} 
                      source={require('../assets/check.png')}
                    />
                </View>
            </TouchableHighlight>
        );
    }
    else {
        return (
            <TouchableHighlight onPress={this.props.onPress} underlayColor='white'>
                <View style={[styles.container, this.props.selected ? styles.selected : styles.deselected]}>
                    <Text 
                      style={[styles.title, this.props.selected ? styles.selectedTitle : styles.deselectedTitle]}>
                        {this.props.title}
                    </Text>
                </View>
            </TouchableHighlight>
        );
    }
  }
}

const styles = StyleSheet.create({
    container: {
        marginTop: 10,
        marginBottom: 10,
        marginLeft: 20,
        marginRight: 20,
        minWidth: 100,
        paddingLeft: 16,
        paddingRight: 16,
        justifyContent: 'center',
        // flexDirection: 'row',
        borderWidth: 2,
        borderRadius: 4,
        height: 50,
    },
    check: {
        position: 'absolute',
        alignSelf: 'flex-end',
        right: 16
    },
    title: {
        fontSize: 17
    },
    deselected: {
        backgroundColor: 'rgba(0,0,0,.03)',
        borderColor: 'rgba(0,0,0,.3)',
    },
    deselectedTitle: {
        color: 'black',
    },
    selected: {
        backgroundColor: '#16966A1A',
        borderColor: '#16966A',
    },
    selectedTitle: {
        color: '#16966A',
        fontWeight: 'bold'
    }
  })

AppRegistry.registerComponent('AnswerButton', () => AnswerButton);
