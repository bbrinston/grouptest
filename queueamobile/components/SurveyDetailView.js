import React, { Component } from 'react';
import { AppRegistry, Text, StyleSheet, View, SectionList, Alert } from 'react-native';
import QAButton from './QAButton';
import AnswerButton from './AnswerButton';

export default class SurveyDetailView extends Component {
    static navigationOptions = ({ navigation }) => ({
        headerTitle: 'Survey',
        headerTintColor: '#16966A',
        headerTitleStyle: {
            color: 'black',
        }
    });

    constructor(props) {
      super(props);
      this.state = { storedAnswer: 0 };
    }

    render() {
      const { questionText, id, answerChoices, numResponses } = this.props.navigation.state.params

      selectAnswer = (id) => {
        this.setState({storedAnswer: id})
      }

      submitAnswer = () => {
        if (this.state.storedAnswer > 0) {
          // Pull class information
          fetch('http://localhost:8000/API/StudentAnswerQuestion.php', {
            method: 'POST',
            headers: {
              Accept: 'application/json',
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({
              pollID: id,
              answer: this.state.storedAnswer,
            }),
          }).then((response) => response.json()).then((responseJson) => {
            // Check response
            if (!(responseJson.error === '' || responseJson.error === null)) {
              Alert.alert(
                'Answer did not send',
                '' + responseJson.error,
                [
                  {text: 'OK', onPress: () => console.log('OK Pressed')},
                ],
                { cancelable: false }
              )
            }
          }).catch((error) => {
            Alert.alert(
              'Answer did not send',
              '' + error,
              [
                {text: 'OK', onPress: () => console.log('OK Pressed')},
              ],
              { cancelable: false }
            )
          });
        }
      }

      return (
        <View style={styles.container}>
            <SectionList
                sections={[{title: questionText, data: answerChoices}]}
                renderItem={({item}) =>
                    <View>
                        <AnswerButton
                            onPress={() => selectAnswer(item.index)}
                            selected={this.state.storedAnswer == item.index}
                            title={item.answer}
                        />
                    </View>
                }
                renderSectionHeader={({section}) => <Text style={styles.sectionHeader}>{section.title}</Text>}
                keyExtractor={(item, index) => index}
            />
            <QAButton
              disabled={this.state.storedAnswer == 0}
              onPress={() => submitAnswer()}
              title='Submit'
            />
        </View>
      )
    }
}

const styles = StyleSheet.create({
    container: {
        backgroundColor: 'white',
    },
    sectionHeader: {
        paddingTop: 30,
        paddingLeft: 20,
        paddingRight: 20,
        paddingBottom: 30,
        fontSize: 17,
        backgroundColor: 'white',
        fontWeight: 'bold'
    },
    choice: {
        paddingLeft: 30,
        paddingRight: 30,
        paddingTop: 20,
        paddingBottom: 6,
        fontSize: 17,
        fontWeight: 'bold',
    },
    sessionResponses: {
        paddingLeft: 30,
        paddingRight: 30,
        paddingBottom: 20,
        fontSize: 15,
        color: 'rgba(0,0,0,.5)'
    },
    separator: {
        backgroundColor: 'rgba(0,0,0,.1)',
        marginLeft: 30,
        height: 1
    }
});

AppRegistry.registerComponent('SurveyDetailView', () => SurveyDetailView);
