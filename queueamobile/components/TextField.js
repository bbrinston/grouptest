import React, { Component } from 'react';
import { Platform, AppRegistry, TextInput, StyleSheet } from 'react-native';

export default class TextField extends Component {
  constructor(props) {
    super(props);
    this.state = { text: '' };
  }

  onChangeText(text) {
    this.setState({text})
    this.props.onChangeText(text)
  }

  render() {
    return (
      <TextInput
        style={styles.textField}
        underlineColorAndroid='rgba(0,0,0,0)'
        onChangeText={(text) => this.onChangeText(text)}
        value={this.props.text}
        placeholder={this.props.placeholder}
        keyboardType={this.props.keyboardType}
        autoCapitalize={this.props.autoCapitalize}
      />
    );
  }
}

const styles = StyleSheet.create({
  textField: {
    borderWidth: 2,
    borderColor: 'rgba(0,0,0,.3)',
    borderRadius: 4,
    height: 50,
    alignSelf: 'stretch',
    marginTop: 10,
    marginBottom: 10,
    padding: 10,
    fontSize: 15
  }
});

AppRegistry.registerComponent('TextField', () => TextField);
