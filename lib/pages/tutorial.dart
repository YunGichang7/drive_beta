import 'package:flutter/material.dart';

class TutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // 글을 상단에 정렬
          children: [
            SizedBox(height: 100), // 상단 여백 추가
            Text(
              '본인 성함과 차량 번호 4자리를 입력해 주신 후 시동을 거시면 자동으로 차량과 어플리케이션이 연결이 됩니다.\n\n'
                  '시동을 거신 순간부터 점수의 측정이 시작됩니다. 점수를 확인하시면서 오는 피드백에 따라 운전 습관을 바꿔가며 운전해주시면 됩니다.\n\n'
                  '운전이 종료된 후 end driving을 누르시면 이번 운전에서의 가/감점 요소를 확인하실 수 있습니다.\n\n'
                  '최종 점수를 확인하시고 데이터 전송을 눌러주시면 됩니다.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,  // Line spacing
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
