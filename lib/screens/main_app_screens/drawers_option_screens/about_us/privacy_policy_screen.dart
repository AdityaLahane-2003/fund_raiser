import 'package:flutter/material.dart';

import '../../../../components/footer.dart';
import '../../../../models/expandable_item.dart';
import '../../../../utils/constants/color_code.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: const [
        Footer(),
      ],
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/logo.png', // Replace with your image asset
              height: 100,
            ),
            const SizedBox(height: 26.0),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                  """Our App TAARN values the trust you place in us. That's why we insist upon the highest standards for secure transactions and User information privacy. Please read the following statement to learn about our information gathering and dissemination practices. The following Privacy Policy should be read along with the TAARN – Terms of Use for a full understanding of TAARN's practices as well as the Users responsibilities when interacting with the TAARN, mobile application and m-site (hereinafter referred to as “Platform”). This Privacy Policy is published in accordance with the provisions of the Indian Information Technology Act, 2000 and the rules made thereunder, specifically, The Information Technology (Reasonable Security Practices and Procedures and Sensitive Personal data or information) Rules, 2011 and the Information Technology (Intermediary Guidelines) Rules, 2011. All terms used in this Privacy Policy will have the same meaning and definition assigned to them in the Information Technology Act, 2000 and the rules made thereunder.

Note:

Our privacy policy is subject to change at any time without notice. To make sure you are aware of any changes, please review this policy periodically.
By visiting this Platform you agree to be bound by the terms and conditions of this Privacy Policy and the Terms of Use of the Platform. If you do not agree please do not use or access the Platform.
By mere use of the Platform, you expressly consent to our use and disclosure of your personal information in accordance with this Privacy Policy. This Privacy Policy is incorporated into and subject to the Terms of Use."""),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: expandableItems.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    leading: Text(
                      '${index + 1} .',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // backgroundColor: Colors.green.shade100,
                    title: Text(expandableItems[index].title),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onExpansionChanged: (isExpanded) {
                      setState(() {
                        _expandedIndex = isExpanded ? index : null;
                      });
                    },
                    initiallyExpanded: index == _expandedIndex,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(expandableItems[index].description),
                      ),
                      const Divider(
                        thickness: 1,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<ExpandableItem> expandableItems = [
  ExpandableItem(
    title:
        '1. Permission Request for Access to Photos, Videos, Files, and SMS',
    subtitle: 'Subtitle 1',
    description:"""We are excited to welcome you to our app! To provide you with the best experience and ensure seamless functionality, we kindly ask for your permission to access certain features on your device.

Photos, Videos, and Files: Our app allows you to create campaigns and share your stories through photos, videos, and documents. To enable this functionality, we require access to your device's external storage to upload and manage these media files. Rest assured, we respect your privacy and will only access files necessary for app usage.
SMS Permissions: For security purposes, we use SMS verification to authenticate your account during sign-up and login processes. This ensures that your account remains secure and protected from unauthorized access. We assure you that we will not misuse your phone number or send unsolicited messages.
Notifications: Stay updated and informed about your campaigns' progress, donations, and other important updates through notifications. We strive to keep you engaged and informed about activities related to your campaigns and the app.
Your privacy and security are our top priorities. We adhere to strict data protection measures and only collect information essential for app functionality. Your personal data will never be shared with third parties without your consent.

Thank you for choosing our app. By granting these permissions, you allow us to deliver a seamless and personalized experience tailored to your needs. Should you have any concerns or questions regarding permissions or privacy, please feel free to contact us.
Best regards,
TAARN Team

"""),  ExpandableItem(
    title:
        '2. Collection and Storing images and videos and their Usage',
    subtitle: 'Subtitle 1',
    description:"""
      Disclosure of image/video/file collection: We declare that our app TAARN collects user images, videos, and files. Images are collected for profile pictures and as cover photos for campaigns within our app. Additionally, when users create campaigns, we collect photos, videos, and files related to the campaign for informative purposes. This data is stored on Firestore exclusively for app usage and is not shared elsewhere.

Explanation of image/video/file usage: User images are used for displaying in user profiles and campaign creators' images are utilized on campaign cards and as cover photos for campaigns. When displaying campaigns, the cover photo collected is used on the campaign card, and uploaded images, videos, and files related to the campaign are displayed on the campaign page for users to explore further.

User control: Users have the option to proceed without uploading a profile photo. While creating a campaign, uploading a cover photo and campaign creator's photo is required for enhanced usability, but other campaign-related photos, videos, and files are optional. Users may choose to upload additional content at their discretion.

We use this information solely for the purpose of providing and improving the functionality of the App, optimizing user experience, and customizing content. Your personal information, including images, videos, and documents, will not be shared with third parties except as necessary to operate the App or comply with legal obligations. By using the App, you consent to the collection and use of your personal information as described in this Privacy Policy.

Your personal information, including images and videos, may be used for in-app campaigns within the App to enhance user engagement and promote relevant content. If a user uploads a profile photo or campaign cover photo or campaign-related other photos and videos and files then the user can't delete these media but we'll add this functionality to delete the uploaded media."""),
   ExpandableItem(
    title:
        '3. Contact List Information Collection, Usage, and Disclosure Policy',
    subtitle: 'Subtitle 1',
    description:"""Our app, TAARN, may request and collect information from your device's Contact List. The information collected may include names, phone numbers, email addresses, and other relevant contact details.

Purpose of Collection:
The Contact List information is collected for the following purposes:

Enhanced User Experience: Displaying contact names in the app to create a personalized and user-friendly experience.
Account Verification: Utilizing phone numbers or email addresses for account verification, such as sending One-Time Passwords (OTPs) for user authentication.
Communication: Sending notifications, updates, or other relevant information to users via their saved contact details.
Usage and Disclosure:
We respect your privacy, and the Contact List information collected will only be used for the purposes mentioned above. We do not sell, share, or disclose this information to third parties without your explicit consent, except as required by law.

User Control and Consent:
By using our app, you consent to the collection and use of your Contact List information as outlined in this privacy policy. You have the option to grant or deny access to your Contact List through app settings.

Review and Update:
This privacy policy is subject to change, and any updates will be reflected in the app and on our website. It is advised to review this policy periodically."""),
  ExpandableItem(
    title:
        '4. Collection of Personally Identifiable Information and other Information',
    subtitle: 'Subtitle 1',
    description:
        """When you use our Platform, we collect and store your personal information, which is provided by you from time to time. Our primary goal in doing so is to provide you a safe, efficient, smooth and customized experience. This allows us to provide services and features that most likely meet your needs, and to customize our Platform to make your experience safer and easier. More importantly, while doing so we collect personal information from you that we consider necessary for achieving this purpose.

In general, you can browse the Platform without telling us who you are or revealing any personal information about yourself. Once you give us your personal information, either by signing up through our portal, you are not anonymous to us. Where possible, we indicate which fields are required and which fields are optional. You always have the option to not provide information by choosing not to use a particular service or feature on the Platform. We may automatically track certain information about you based upon your behavior on our Platform. We use this information to do internal research on our users' demographics, interests, and behavior to better understand, protect and serve our users. This information is compiled and analyzed on an aggregated basis. This information may include the URL that you just came from (whether this URL is on our Platform or not), which URL you next go to (whether this URL is on our Platform or not), your computer browser information, and your IP address.

We use data collection devices such as "cookies" on certain pages of the Platform to help analyze our web page flow, measure promotional effectiveness, and promote trust and safety. "Cookies" are small files placed on your hard drive that assist us in providing our services. We offer certain features that are only available through the use of a "cookie".

We also use cookies to allow you to enter your password less frequently during a session. Cookies can also help us provide information that is targeted to your interests. Most cookies are "session cookies," meaning that they are automatically deleted from your hard drive at the end of a session. You are always free to decline our cookies if your browser permits. At this time, all features of the Platform will work even if you disable cookies. However, in the future and in the event that we add certain new or improvised features and services to the Platform, the Platform or some parts of it may not be accessible if cookies are disabled. You may also be required to re-enter your password more frequently during a session.

Additionally, you may encounter "cookies" or other similar devices on certain pages of the Platform that are placed by third parties. We do not control the use of cookies by third parties.

If you choose to donate or contribute on or through the Platform, we collect information about your donations patterns and generally your usage behavior.

If you send us personal correspondence, such as emails or letters, or if other users or third parties send us correspondence about your activities or postings on the Platform, we may collect such information into a file specific to you.

We collect personally identifiable information (email address, name, phone number,images,videos, files) from you when you set up an account with us and when you create campaign. While you can browse some sections of our Platform without being a registered member, certain activities (such as making a donation / contribution) do require registration. We also provide certain data to the Campaigner to interact with you and send you information of the type aforementioned as well as to complete certain transactions and fulfill commitments such as rewards, updates and the like.
""",
  ),
  ExpandableItem(
    title: '5. Use of Demographic / Profile Data / Your Information',
    subtitle: 'Subtitle 2',
    description:
        '''We use personal information to provide the services you request. To the extent we use your personal information to market to you, we will provide you the ability to opt-out of such uses. We use your personal information to resolve disputes; troubleshoot problems; help promote a safe service; measure User interests in Fundraisers hosted on our App, inform you about updates; customize your experience; detect and protect us against error, fraud and other criminal activity; enforce our terms and conditions; and as otherwise described to you at the time of collection.

In our efforts to continually improve our product and service offerings, we collect and analyze demographic and profile data about our users' activity on our Platform.

We identify and use your IP address to help diagnose problems with our server, and to administer our Platform. Your IP address is also used to help identify you and to gather broad demographic information.''',
  ),
  ExpandableItem(
      title: "6. Sharing of personal information",
      subtitle: 'Subtitle 3',
      description:
          """The following is information that we will not share with any third parties or disclose to any person other than as required by law; Sensitive Personal Data or Information of any person being the password, financial information such as Bank account or credit card or debit card or other payment instrument details, sexual orientation or any other sensitive personal information not essential for the continued use of the Platform.

We may share your personal information with third party vendors or our other corporate and /or associate entities and affiliates to help with identity verification; detect and prevent identity theft, fraud, other potentially illegal acts and cyber security incidents; correlate related or multiple accounts to prevent abuse of our services; and to facilitate joint or co-branded services that you request where such services are provided by more than one associate entity.
In certain cases, in order to provide you with services, we may receive your personal information (such as your Permanent Account Number) from third parties regarding the verification of your identity status. In order to avail these services from third parties we may be required to share your personal information available with us (for instance, your mobile number) with the third party. We will only collect from and share your personal information with third parties if it is strictly necessary for the provision of our services. We do not retain the data obtained from these third parties for any purpose other than the provision of our services to you. Taarn assumes no liability and is not responsible for the manner in which third parties gather and extract your personal information. These entities and affiliates may not market to you as a result of such sharing unless you explicitly opt-in.
We may disclose personal information if required to do so by law or in the good faith belief that such disclosure is reasonably necessary to respond to summons, court orders, or other legal process. We may disclose personal information to law enforcement offices, third party rights owners, or others in the good faith and belief that such disclosure is reasonably necessary to: enforce our Terms of Use or Privacy Policy; respond to claims that an advertisement, posting or other content violates the rights of a third party; or protect the rights, property or personal safety of our users or the general public.
We and our affiliates will share, part with and allow any other business entity to use the personal information provided by the User to Taarn, in the event we (or our assets) plan to merge with, or be acquired by that business entity, or re-organization, amalgamation, restructuring of business. Should such a transaction occur that other business entity (or the new combined entity) will be required to follow this privacy policy with respect to your personal information.
"""),
//   ExpandableItem(
//       title: "Links to Other Sites",
//       subtitle: 'Subtitle 3',
//       description:
//           """Our Platform links to other Apps and app that may collect personally identifiable information about you. Taarn is not responsible for the privacy practices or the content of those linked Apps and app.
// """),
  ExpandableItem(
      title: "7. Security Precautions / Security Breach",
      subtitle: 'Subtitle 3',
      description:
          """Our Platform has stringent security measures in place to protect the loss, misuse, and alteration of the information under our control. Whenever you change or access your account information, we offer the use of a secure server. Once your information is in our possession we adhere to strict security guidelines, protecting it against unauthorized access. Our app uses industry grade and standardized methods to protect your information from any misuse.

If any User has sufficient reason to believe their Data as regarded as that which we do not share with third parties, has been compromised or there has been a breach of security due to a cyber security incident, you may write to us immediately at the contact details mentioned below so that we may take suitable measures to either rectify such a breach and inform the concerned authorities of a cyber security incident.

To report an abuse on the Platform, not being a cyber security incident, a User may click on the Report Abuse tab found at the bottom of the page and provide details of the abuse. Upon receiving such information Taarn will examine the abuse and take suitable and necessary steps to remedy it.
"""),
  ExpandableItem(
      title:
          "8. Review of Information / Account Deactivation / Removal of Information",
      subtitle: 'Subtitle 3',
      description:
          """Users can delete there acocunt from the app and there authentication data will be removed from the app, but the campaign-related data will not be deleted from the app.
For the deletion of the campaign-related data, the user has to write to us at foundationtaran@gmail.com

If at any time a User wishes to review the information provided to Taarn at the time of registering with Taarn or at any time thereafter, you may do so by signing into your account and amending the same.

We provide all users with the opportunity to opt-out of receiving non-essential (promotional, marketing-related) communications from us on behalf of our Campaigner, and from us in general, after setting up an account. All Users are also given the option of cancelling their User accounts and bringing to our attention their desire to discontinue the use of our services.

If you want to deactivate your account or remove your contact information from all Taarn.org's lists and newsletters, please write to us at foundationtaran@gmail.com.
"""),
  // ExpandableItem(
  //     title: "Advertisements on Hrtaa.org",
  //     subtitle: 'Subtitle 3',
  //     description:
  //         """We use third-party advertising companies to serve ads when you visit our Platform. These companies may use information (not including your name, address, email address, or telephone number and generally other information which may identify you personally) about your visits to this and other websites and app in order to provide advertisements about goods and services of interest to you."""),
  //
  ExpandableItem(
      title: "9. Your Consent",
      subtitle: 'Subtitle 3',
      description:
          """By using the Platform and/or by providing your information, you consent to the collection and use of the information you disclose on the Platform in accordance with this Privacy Policy, including but not limited to Your consent for sharing your information as per this privacy policy.
If we decide to change our privacy policy, we will post those changes on this page so that you are always aware of what information we collect, how we use it, and under what circumstances we disclose it.

The donors/contributors hereby permit Taarn to share their personal information such as name, email address, contact information to the respective Campaigner and beneficiaries of the donations made by the donors on TAARN.

By continuing to the next step you are willingly giving Taarn permission to contact you via WhatsApp, Email, SMS, and other modes of communication.
"""),ExpandableItem(
      title: "10. Note on Collection of User Information and Data Analytics",
      subtitle: 'Subtitle 3',
      description:
          """
Our Platform may collect and log your IP address when you access or use our services. This information is used for system administration purposes, to diagnose problems with our servers, and to improve the overall user experience. Your IP address may also be used to gather broad demographic information.

In addition, our Platform integrates with Firebase's Crashlytics SDK, a service provided by Google LLC, which collects certain information and data to help us identify and analyze app crashes and errors. This information may include device information, app usage data, and crash logs. The data collected by Firebase's Crashlytics SDK is used solely for the purpose of diagnosing and resolving technical issues within our app, and to improve its stability and performance.

We may also utilize other third-party analytics tools to collect aggregated data on user interactions with our Platform, such as page views, clicks, and other usage patterns. This data helps us understand how users interact with our Platform and enables us to make informed decisions about design, content, and features.

By continuing to use our Platform, you consent to the collection and processing of your information as described in this Privacy Policy, including the collection of your IP address and the use of Firebase's Crashlytics SDK for error reporting and debugging purposes."""),
  ExpandableItem(
      title: "11. Retention of Information",
      subtitle: 'Subtitle 3',
      description:
          """Information provided by you to Taarn is processed, stored and retained through our servers and Firebase database and Firestore storage. Also, some other features are provided by Firebase that we are using in our App.

Our web hosts and agency managing your information are compliant with IS/ISO/IEC27001 or an equivalent in standards of Security Techniques and Information Security Management System Requirements."""),
  // Add more items as needed
];
