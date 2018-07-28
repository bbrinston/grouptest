import React, { Component } from 'react';
import { AppRegistry, View, Text, StyleSheet, Image, TextInput } from 'react-native';
import { KeyboardAwareScrollView } from 'react-native-keyboard-aware-scroll-view';
import TextField from './TextField';
import QAButton from './QAButton';
import Subhead from './Subhead';
import ClassModel from '../models/ClassModel';
import SessionModel from '../models/SessionModel';
import SurveyModel from '../models/SurveyModel';

export default class MyClassesView extends Component {
  static navigationOptions = {
    header: null
  }

  constructor(props) {
    super(props);
    this.state = { 
      id: '',
      errorText: '' 
    };
  }

  render() {
    joinClass = (id) => {
      // Clear error text
      this.setState({errorText: ''})

      // Pull class information
      fetch('http://localhost:8000/API/StudentPullClassInfo.php', {
        method: 'POST',
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          classID: id,
        }),
      }).then((response) => response.json()).then((responseJson) => {
        // Check response
        if (responseJson.error === '' || responseJson.error === null) {
          let myClass = new ClassModel(responseJson.className,
            responseJson.classID, responseJson.professor, responseJson.sessionList)
          this.props.navigation.navigate('ClassDetailView', myClass)
        } else {
          this.setState({errorText: '' + responseJson.error})
        }
      }).catch((error) => {
        console.warn(error)
        this.setState({errorText: '' + error})
      });
    }
    return (
      <KeyboardAwareScrollView contentContainerStyle={styles.container} keyboardDismissMode='on-drag'>
        <View style={styles.form}>
          <Text style={styles.headerText}>
            Join a Class
          </Text>
          <Subhead text='Class ID'/>
          <TextField
            ref='idInput'
            placeholder='Enter the ID given by your instructor'
            keyboardType='numbers-and-punctuation'
            autoCapitalize='characters'
            onChangeText={(id) => this.setState({id})}
            value={this.state.id}
          />
          <QAButton
              disabled={this.state.id == ''}
              onPress={() => joinClass(this.refs.idInput.state.text)}
              title='Join'
          />
          <TextInput
            multiline={true}
            maxLength={200}
            editable={false}
            ref='errorOutput'
            style={styles.headerTextError}
            onChangeText={(errorText) => this.setState({errorText})}
            value={this.state.errorText}
          />
        </View>
        <Image style={styles.logo} source={require('../assets/logo.png')}/>
      </KeyboardAwareScrollView>
    );
  }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#fff',
    },
    form: {
      flex: 1,
      justifyContent: 'center',
      alignItems: 'center',
      marginLeft: 30,
      marginRight: 30,
    },
    headerText: {
        fontSize: 20,
        fontWeight: 'bold',
        textAlign: 'center',
        margin: 40,
        color: 'black'
    },
    errorText: {
        fontSize: 15,
        fontWeight: 'bold',
        textAlign: 'center',
        margin: 40,
        color: 'red'
    },
    logo: {
      position: 'absolute',
      alignSelf: 'center',
      top: 50
    }
});

AppRegistry.registerComponent('MyClassesView', () => MyClassesView);
