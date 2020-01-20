import 'package:flutter/material.dart';

class TermsOfServicePolicy extends StatelessWidget {
  final String termsOfService = """1. Terms
By accessing our app, LifePlus, you are agreeing to be bound by these terms of service, all applicable laws and regulations, and agree that you are responsible for compliance with any applicable local laws. If you do not agree with any of these terms, you are prohibited from using or accessing LifePlus. The materials contained in LifePlus are protected by applicable copyright and trademark law.\n
2. Use License
  a) Permission is granted to temporarily download one copy of LifePlus per device for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title, and under this license you may not:
  i) modify or copy the materials;
  ii) use the materials for any commercial purpose, or for any public display (commercial or non-commercial);
  iii) attempt to decompile or reverse engineer any software contained in LifePlus;
  iv) remove any copyright or other proprietary notations from the materials; or
  v) transfer the materials to another person or "mirror" the materials on any other server.
  b) This license shall automatically terminate if you violate any of these restrictions and may be terminated by Juggle at any time. Upon terminating your viewing of these materials or upon the termination of this license, you must destroy any downloaded materials in your possession whether in electronic or printed format.\n
3. Disclaimer
The materials within LifePlus are provided on an 'as is' basis. Juggle makes no warranties, expressed or implied, and hereby disclaims and negates all other warranties including, without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights.
Further, Juggle does not warrant or make any representations concerning the accuracy, likely results, or reliability of the use of the materials on its website or otherwise relating to such materials or on any sites linked to LifePlus.\n
4. Limitations
In no event shall Juggle or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use LifePlus, even if Juggle or a Juggle authorized representative has been notified orally or in writing of the possibility of such damage. Because some jurisdictions do not allow limitations on implied warranties, or limitations of liability for consequential or incidental damages, these limitations may not apply to you.\n
5. Accuracy of materials
The materials appearing in LifePlus could include technical, typographical, or photographic errors. Juggle does not warrant that any of the materials on LifePlus are accurate, complete or current. Juggle may make changes to the materials contained in LifePlus at any time without notice. However Juggle does not make any commitment to update the materials.\n
6. Links
Juggle has not reviewed all of the sites linked to its app and is not responsible for the contents of any such linked site. The inclusion of any link does not imply endorsement by Juggle of the site. Use of any such linked website is at the user's own risk.\n
7. Modifications
Juggle may revise these terms of service for its app at any time without notice. By using LifePlus you are agreeing to be bound by the then current version of these terms of service.\n
8. Governing Law
These terms and conditions are governed by and construed in accordance with the laws of Delhi, India and you irrevocably submit to the exclusive jurisdiction of the courts in that State or location.""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Services'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Terms of Service",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.008),
              Text(termsOfService),
            ],
          ),
        ),
      ),
    );
  }
}
