import 'package:flutter/material.dart';

class DriveEndPage extends StatefulWidget {
  @override
  _DriveEndPageState createState() => _DriveEndPageState();
}

class _DriveEndPageState extends State<DriveEndPage> {
  final _formKey = GlobalKey<FormState>();

  String? question1;
  String question2 = '';
  int question3 = 5;
  String? question4;
  int question5 = 5;
  int question6 = 5;
  int question7 = 5;
  String question8 = '';
  String question9 = '';
  String question10 = '';

  String getSliderLabel(int value) {
    switch (value) {
      case 1:
        return '전혀 그렇지 않다.';
      case 2:
        return '그렇지 않다.';
      case 3:
        return '보통이다.';
      case 4:
        return '그렇다.';
      case 5:
        return '매우 그렇다.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설문조사'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Question 1
              Text('1. 귀하가 기대한 점수와 실제로 나타나는 점수가 비슷한가요?', style: TextStyle(fontSize: 16)),
              RadioListTile<String>(
                title: Text('예', style: TextStyle(fontSize: 14)),
                value: '예',
                groupValue: question1,
                onChanged: (value) {
                  setState(() {
                    question1 = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('아니요', style: TextStyle(fontSize: 14)),
                value: '아니요',
                groupValue: question1,
                onChanged: (value) {
                  setState(() {
                    question1 = value;
                  });
                },
              ),
              SizedBox(height: 16.0),

              // Question 2
              Text('2. 귀하의 점수가 그렇게 나타난 이유는 무엇이라고 생각하십니까?', style: TextStyle(fontSize: 16)),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    question2 = value;
                  });
                },
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '내 답변',
                ),
              ),
              SizedBox(height: 16.0),

              // Question 3
              Text('3. 점수를 높이기 위한 운전을 하셨나요?', style: TextStyle(fontSize: 16)),
              Slider(
                value: question3.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                label: getSliderLabel(question3),
                onChanged: (value) {
                  setState(() {
                    question3 = value.toInt();
                  });
                },
              ),
              Align(
                alignment: Alignment.center,
                child: Text(getSliderLabel(question3)),
              ),
              SizedBox(height: 16.0),

              // Question 4
              Text('4. 귀하는 서비스를 사용한 후 운전 점수가 높아졌나요?'),
              RadioListTile<String>(
                title: Text('높아졌다.', style: TextStyle(fontSize: 14)),
                value: '높아졌다',
                groupValue: question4,
                onChanged: (value) {
                  setState(() {
                    question4 = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('그대로이다.', style: TextStyle(fontSize: 14)),
                value: '그대로이다',
                groupValue: question4,
                onChanged: (value) {
                  setState(() {
                    question4 = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('낮아졌다.', style: TextStyle(fontSize: 14)),
                value: '낮아졌다',
                groupValue: question4,
                onChanged: (value) {
                  setState(() {
                    question4 = value;
                  });
                },
              ),
              SizedBox(height: 16.0),

              // Question 5
              Text('5. 서비스에 얼마나 만족하시나요?'),
              Slider(
                value: question5.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                label: getSliderLabel(question5),
                onChanged: (value) {
                  setState(() {
                    question5 = value.toInt();
                  });
                },
              ),
              Align(
                alignment: Alignment.center,
                child: Text(getSliderLabel(question5)),
              ),
              SizedBox(height: 16.0),

              // Question 6
              Text('6. 이 서비스가 출시된다면 이용하시겠습니까?'),
              Slider(
                value: question6.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                label: getSliderLabel(question6),
                onChanged: (value) {
                  setState(() {
                    question6 = value.toInt();
                  });
                },
              ),
              Align(
                alignment: Alignment.center,
                child: Text(getSliderLabel(question6)),
              ),
              SizedBox(height: 16.0),

              // Question 7
              Text('7. 서비스를 주변 지인에게 추천하시겠습니까?'),
              Slider(
                value: question7.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                label: getSliderLabel(question7),
                onChanged: (value) {
                  setState(() {
                    question7 = value.toInt();
                  });
                },
              ),
              Align(
                alignment: Alignment.center,
                child: Text(getSliderLabel(question7)),
              ),
              SizedBox(height: 16.0),

              // Question 8
              Text('8. 필요하다고 느껴지는 개선 사항은 무엇인가요?'),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    question8 = value;
                  });
                },
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '내 답변',
                ),
              ),
              SizedBox(height: 16.0),

              // Question 9
              Text('9. 다른 운전 점수 제공 서비스와 비교하여 부족한 점은 무엇인가요?'),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    question9 = value;
                  });
                },
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '내 답변',
                ),
              ),
              SizedBox(height: 16.0),

              // Question 10
              Text('10. 다른 운전 점수 제공 서비스와 비교하여 나은 점은 무엇인가요?'),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    question10 = value;
                  });
                },
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '내 답변',
                ),
              ),
              SizedBox(height: 16.0),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // 처리할 로직을 여기에 작성하세요.
                    print('질문1: $question1');
                    print('질문2: $question2');
                    print('질문3: $question3');
                    print('질문4: $question4');
                    print('질문5: $question5');
                    print('질문6: $question6');
                    print('질문7: $question7');
                    print('질문8: $question8');
                    print('질문9: $question9');
                    print('질문10: $question10');
                  }
                },
                child: Text('제출'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
