import React, { Component } from 'react';
import { AppRegistry, StyleSheet, Text } from 'react-native';

export default class Subhead extends Component {
  render() {
    return (
        <Text style={styles.subhead}>
            {this.props.text}
        </Text>
    );
  }
}

const styles = StyleSheet.create({
    subhead: {
      color: 'black',
      fontSize: 17,
      alignSelf: 'stretch'
    }
  })

AppRegistry.registerComponent('Subhead', () => Subhead);
