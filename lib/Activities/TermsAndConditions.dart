// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class termsAndConditions extends StatefulWidget {
  const termsAndConditions({super.key});

  @override
  State<termsAndConditions> createState() => _termsAndConditionsState();
}

class _termsAndConditionsState extends State<termsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms & Conditions'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    fontSize: 25,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Electronic Communications When you visit the Site or send e-mails to us, you are communicating with us electronically. You consent to receive communications from us electronically. We will communicate with you by e-mail or by posting notices on this Site. You agree that all agreements, notices, disclosures and other communications that we provide to you electronically satisfy any legal requirement that such communications be in writing.',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Copyright All content included on this Site, such as text, graphics, logos, button icons, images, audio clips, digital downloads, data compilations, and software, is the property of Amazon or its affiliates or its content suppliers and protected by United States, Luxembourg, United Kingdom, India and international copyright laws. The compilation of all content on this Site is the exclusive property of Amazon or its affiliates and protected by United States, Luxembourg, United Kingdom, India and international copyright laws. All software used on this Site is the property of Amazon, its affiliates or its software suppliers and protected by United States, Luxembourg, United Kingdom, India and international copyright laws.',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Trademarks Amazon, the Amazon logo, Amazon Services India, and other marks indicated on our Site are trademarks of Amazon or its affiliates in the United States and other countries. Other Amazon graphics, logos, page headers, button icons, scripts, and service names are trademarks or trade dress of Amazon or its affiliates. Amazon and its affiliates’ trademarks and trade dress may not be used in connection with any product or service that is not Amazon or its affiliates’ as applicable, in any manner that is likely to cause confusion among users, or in any manner that disparages or discredits Amazon or its affiliates. All other trademarks not owned by Amazon or its affiliates that appear on this site are the property of their respective owners, who may or may not be affiliated with, connected to, or sponsored by Amazon or its affiliates.',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'License and site access Amazon Seller Services Private Limited grants you a limited license to access and make personal use of this Site and not to download (other than page caching) or modify it, or any portion of it, except with express written consent of Amazon Seller Services Private Limited and / or its affiliates, as may be applicable. This license does not include any resale or commercial use of this site or its contents; any derivative use of this site or its contents; or any use of data mining, robots, or similar data gathering and extraction tools. This site or any portion of this site (including but not limited to any copyrighted material, trademarks, or other proprietary information) may not be reproduced, duplicated, copied, sold, resold, visited, or otherwise exploited for any commercial purpose without express written consent of Amazon Seller Services Private Limited and / or its affiliates, as may be applicable. You may not frame or utilize framing techniques to enclose any trademark, logo, or other proprietary information (including images, text, page layout, or form) of Amazon Seller Services Private Limited or its affiliates without their express written consent. You may not use any meta tags or any other “hidden text” utilizing Amazon Seller Services Private Limited"s or its affiliates name or trademarks without their express written consent. Any unauthorized use terminates the permission or license granted by Amazon Seller Services Private Limited and / or its affiliates. You are granted a limited, non-assignable, revocable, and non-exclusive right to create a hyperlink to the home page of services.amazon.in so long as the link does not portray Amazon Seller Services Private Limited, its affiliates, or their products or services in a false, misleading, derogatory, or otherwise offensive matter. You may not use any logo or other proprietary graphic or trademark of Amazon Seller Services Private Limited or its affiliates as part of the link without their express written permission.',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      // Text("Electronic Communications When you visit the Site or send e-mails to us, you are communicating with us electronically. You consent to receive communications from us electronically. We will communicate with you by e-mail or by posting notices on this Site. You agree that all agreements, notices, disclosures and other communications that we provide to you electronically satisfy any legal requirement that such communications be in writing. Copyright All content included on this Site, such as text, graphics, logos, button icons, images, audio clips, digital downloads, data compilations, and software, is the property of Amazon or its affiliates or its content suppliers and protected by United States, Luxembourg, United Kingdom, India and international copyright laws. The compilation of all content on this Site is the exclusive property of Amazon or its affiliates and protected by United States, Luxembourg, United Kingdom, India and international copyright laws. All software used on this Site is the property of Amazon, its affiliates or its software suppliers and protected by United States, Luxembourg, United Kingdom, India and international copyright laws.Trademarks Amazon, the Amazon logo, Amazon Services India, and other marks indicated on our Site are trademarks of Amazon or its affiliates in the United States and other countries. Other Amazon graphics, logos, page headers, button icons, scripts, and service names are trademarks or trade dress of Amazon or its affiliates. Amazon and its affiliates’ trademarks and trade dress may not be used in connection with any product or service that is not Amazon or its affiliates’ as applicable, in any manner that is likely to cause confusion among users, or in any manner that disparages or discredits Amazon or its affiliates. All other trademarks not owned by Amazon or its affiliates that appear on this site are the property of their respective owners, who may or may not be affiliated with, connected to, or sponsored by Amazon or its affiliates.License and site access Amazon Seller Services Private Limited grants you a limited license to access and make personal use of this Site and not to download (other than page caching) or modify it, or any portion of it, except with express written consent of Amazon Seller Services Private Limited and / or its affiliates, as may be applicable. This license does not include any resale or commercial use of this site or its contents; any derivative use of this site or its contents; or any use of data mining, robots, or similar data gathering and extraction tools. This site or any portion of this site (including but not limited to any copyrighted material, trademarks, or other proprietary information) may not be reproduced, duplicated, copied, sold, resold, visited, or otherwise exploited for any commercial purpose without express written consent of Amazon Seller Services Private Limited and / or its affiliates, as may be applicable. You may not frame or utilize framing techniques to enclose any trademark, logo, or other proprietary information (including images, text, page layout, or form) of Amazon Seller Services Private Limited or its affiliates without their express written consent. You may not use any meta tags or any other “hidden text” utilizing Amazon Seller Services Private Limited's or its affiliates name or trademarks without their express written consent. Any unauthorized use terminates the permission or license granted by Amazon Seller Services Private Limited and / or its affiliates. You are granted a limited, non-assignable, revocable, and non-exclusive right to create a hyperlink to the home page of services.amazon.in so long as the link does not portray Amazon Seller Services Private Limited, its affiliates, or their products or services in a false, misleading, derogatory, or otherwise offensive matter. You may not use any logo or other proprietary graphic or trademark of Amazon Seller Services Private Limited or its affiliates as part of the link without their express written permission.Your activity on the amazon services site Amazon Site is not intended for use by children. If you are a minor i.e. under the age of 18 years, you may use the Site and Amazon only with involvement of a parent or guardian. Amazon and its affiliates reserve the right to refuse service, terminate accounts, or remove or edit content in their sole discretion You must not use the Site in any way that causes, or is likely to cause, the website or access to it to be interrupted, damaged or impaired in any way. You understand that you, and not Amazon, are responsible for all electronic communications and content sent from your computer to us and you must use the Site for lawful purposes only and only in accordance with the applicable law."),
    );
  }
}
