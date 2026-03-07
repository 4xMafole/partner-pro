import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'terms_of_use_page_model.dart';
export 'terms_of_use_page_model.dart';

class TermsOfUsePageWidget extends StatefulWidget {
  const TermsOfUsePageWidget({super.key});

  static String routeName = 'terms_of_use_page';
  static String routePath = '/termsOfUsePage';

  @override
  State<TermsOfUsePageWidget> createState() => _TermsOfUsePageWidgetState();
}

class _TermsOfUsePageWidgetState extends State<TermsOfUsePageWidget> {
  late TermsOfUsePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TermsOfUsePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.safePop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                        ),
                        Text(
                          'Terms of Use',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .headlineMediumFamily,
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 22.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .headlineMediumIsCustom,
                              ),
                        ),
                      ].divide(SizedBox(width: 10.0)),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(),
                          child: MarkdownBody(
                            data:
                                '''**PARTNERPRO Terms of Use**\\\n*Updated September 8, 2025*\n\nWelcome, and thank you for choosing PARTNERPRO. By registering for an\naccount, using our services, or accessing content via our websites,\nnetworks, or mobile apps, you agree to be bound by the following terms\nof use, which may be updated periodically (\\\"Terms of Use\\\").\n\n**1. Our Role**\\\nAt PARTNERPRO, we aim to help you navigate various tasks involved in a\nreal estate transaction. However, unless explicitly mentioned in the\nspecific terms of use for a particular service, I do not provide\nfinancial or real estate advice of any kind. You also understand that\nads may be shown while using the services, and these advertisements may\nbe tailored based on the data collected through your interactions with\nthe platform. More information is available in the Privacy Policy.\n\n**A. Real Estate Broker Licensing**\\\nWhile PARTNERPRO holds a real estate broker license in certain states,\nunless otherwise stated in the terms for your specific product or\nservice, we assume no responsibility for any outcomes, whether directly\nor indirectly related to any actions you or other users take based on\nthe information provided.\n\n**3. Eligibility and Account Registration**\\\nTo use PARTNERPRO services, you need to be at least 18 years old. By\nagreeing to these Terms of Use, you confirm that you meet this\nrequirement, haven\'t been suspended or removed from the platform, and\nyour registration complies with applicable laws. If you\'re signing up\nfor an account, you\'ll need to provide accurate information such as your\nemail and phone number, and it\'s your responsibility to keep this\ninformation updated. You\'re also responsible for maintaining the\nconfidentiality of your account details and any actions performed under\nyour account. Unless you\'ve entered into a commercial agreement, once\navailable, you can only use the platform for your own real estate\ntransactions.\n\n**4. Using Our Services and Restrictions**\\\nAs long as you comply with these Terms of Use, you\'ll have access to the\nservices on a limited, personal, non-transferable basis. If you\'re a\nreal estate or mortgage professional, you may use the services to assist\nyour clients, as long as you\'ve obtained the required permissions and\ndisclose all actions and intent. Unless explicitly allowed, these terms\ndo not permit you to share or display any portion of the platform on\nthird-party websites.\n\n**A. Mobile Apps**\\\nTo access any mobile features on PARTNERPRO, you\'ll need a compatible\ndevice. We cannot guarantee that every app will work with your device.\nYou may incur charges from your wireless provider for using mobile data,\nand you\'re responsible for these costs. The app may automatically\nupdate, and by using it, you agree to these automatic upgrades. The\nTerms of Use apply to any updated versions.\n\n**B. Content Use**\\\nYou may copy information from PARTNERPRO for personal or professional\nuse, such as viewing, printing, or emailing details. However, if using\naggregate data for non-personal purposes, like real estate market\nanalysis, you must credit PARTNERPRO on each page where the data is\nused. You cannot use our logos or imply a relationship without prior\napproval.\n\n**5. Prohibited Use**\\\nBy using PARTNERPRO, you agree not to:\n\n- Modify, distribute, reverse engineer, or create derivative works from\n  any part of the platform.\n\n- Use any automated tools (spiders, robots, etc.) to gather information\n  from the services.\n\n- Post illegal, offensive, or objectionable content, including\n  harassment or discrimination.\n\n- Interfere with or compromise the security of the platform.\n\n- Use the platform to develop competing products.\n\nIf you\'re found to violate these rules, PARTNERPRO reserves the right to\ntake appropriate action.\n\nBy agreeing to these terms, you\'re making sure you use PARTNERPRO\nresponsibly and fairly. If you have any questions or concerns about\nthese guidelines, feel free to reach out!\n\n**6. Fees**\n\n**A. General Terms**\\\nIf you want access to certain features or services we offer, you might\nneed to pay a fee. All payments are in U.S. dollars, and they\'re\nnon-refundable. If we decide to change fees or add new charges, we\'ll\nlet you know ahead of time. If those changes don\'t work for you, we\nmight stop offering that part of the service to you. Any payments will\nbe processed by trusted third-party providers using the accepted payment\nmethod you chose when signing up. By using the service, you give us\npermission to charge those fees as outlined in these terms. If you\'re\npaying by credit card, we might pre-authorize your card to ensure its\nvalid and has enough funds to cover the charge.\n\n**7. User Materials**\n\n**A. Uploading Content and Granting a License**\\\nSome parts of our service allow you to upload images, photos, data, or\nother materials (your \"User Materials\"). By sharing your content, you\'re\ngiving us a perpetual, royalty-free license to use, display, edit, and\ndistribute that content as we see fit. We can also share this license\nwith others. We won\'t pay you for your content or to use it, and we can\nremove or modify it at any time. You\'re responsible for anything you\nupload, and you promise that you own it or have the rights to share it.\nAny client information you upload will only be used for the service\nunless the client provides it directly to us.\n\n**B. Disclaimer for User Materials**\\\nPARTNERPRO is not responsible for monitoring or controlling your User\nMaterials or anyone else\\\'s. But if we see something that doesn\'t align\nwith our policies, we might remove or block it without warning. You\nmight encounter other users\' content that you find inappropriate or\noffensive---that\'s not on us, and by using our services, you waive any\nlegal rights to claim against us because of someone else\'s materials.\n\n**8. Third-Party Services and Links**\n\n**A. General Information**\\\nPARTNERPRO might include links to third-party products or services, but\nthese are provided by companies outside our control. If you interact\nwith any third-party provider, that\'s between you and them. You\'re\nresponsible for understanding and complying with their terms and\npolicies. We\'re not endorsing nor responsible for their services or how\nthey handle your information. If you submit a form to contact a\nthird-party provider, they might call you, and they could keep your\ncontact details for future use. Any issues or costs related to\nthird-party dealings are not our responsibility.\n\n**B. Specific Third-Party Services**\n\n- **Referrals and Leads**: We may connect you with a real estate\n  professional or other service. By using our services, you give us\n  permission to make such referrals, and we may receive compensation for\n  doing so.\n\n- **Non-Affiliated Financial Products**: If you choose to contact a bank\n  or lender through our services, we may pass your information along,\n  and your identity will be shared with them. we don\'t guarantee loan\n  approval or the best rates. All decisions about loans are made by\n  third-party providers, not by PARTNERPRO.\n\n**9. Intellectual Property**\n\nWe own everything that\'s part of my service---designs, code, graphics,\netc.---unless otherwise noted. You\'re not allowed to use any of this\ncontent unless these terms explicitly say you can.\n\n**10. Feedback**\n\nIf you give us feedback or suggestions on how to improve our services,\nwe are free to use those ideas however we want, without compensating\nyou. You\'re granting us the right to do that indefinitely.\n\n**11. Copyright Infringement (DMCA)**\n\nWe respect copyright laws, and we expect you to do the same. If you\nthink your work has been copied or used without permission on our\nservices, you can notify us following the process outlined below. We\'ll\nneed certain details, like what material you think is infringing and how\nwe can contact you.\n\n**12. Account Changes and Termination**\n\nYou can deactivate or delete your account whenever you want by following\nthe options in your account settings. If you do, you\'re still\nresponsible for any fees incurred before closing the account. If we\nthink you\'ve violated my terms, we can terminate your access to the\nservice at any time without warning. Additionally, we can change,\nsuspend, or discontinue parts of the service whenever we deem necessary.\nWe\'ll let you know about significant updates, and by continuing to use\nthe service, you\'re agreeing to those changes. It\'s up to you to review\nthe terms regularly.\n\n**13. Privacy Policy and Additional Terms**\n\n**A. Privacy**\\\nWe collect and use your personal information as detailed in my Privacy\nPolicy, which is part of these terms.\n\n**B. Other Terms**\\\nThere may be additional guidelines or rules that apply to specific\nservices or products, which are also part of these terms. Make sure to\ncheck any relevant agreements or guidelines that apply to what you\'re\nusing.\n\n**14. Indemnification:** By using PARTNERPRO services, you agree to take\nfull responsibility for protecting, defending, and covering any claims\nor legal demands made by third parties as a result of your actions. This\nincludes: (a) your access or use of the services, (b) any violation of\nthese terms, (c) breaching laws or infringing on others\\\' rights, (d)\ndisputes you may have with third parties, (e) any content or materials\nyou upload, (f) intentional misconduct, and (g) misuse of your account.\nIf necessary, PARTNERPRO may step in to handle a legal defense, and you\nagree to cooperate fully in this situation.\n\n**15. No Warranties:** PARTNERPRO provides all services \\\"as is,\\\"\nwithout guarantees. The responsibility for quality, performance, and\nresults rests solely on you. Neither PARTNERPRO nor its partners make\nany promises about the functionality, suitability, or security of the\nservices. We specifically disclaim warranties related to\nmerchantability, fitness for a particular purpose, and uninterrupted\nservice. Any advice or information you receive from us doesn\'t create a\nwarranty unless it\'s explicitly stated. You are using the services at\nyour own risk, and you\'re responsible for any damages to your devices or\ndata loss that may result.\n\n**16. Limitation of Liability/Exclusive Remedy:** PARTNERPRO and our\naffiliates are not responsible for indirect, special, or punitive\ndamages such as lost profits or goodwill. This applies even if we\\\'ve\nbeen informed of potential issues. Some areas may not allow the\nexclusion of certain liabilities, so parts of this may not apply to you.\nEach limitation is designed to allocate risk between us and will apply\neven if a remedy fails.\n\n**17. Choice of Law; Disputes:** These terms are governed by the laws of\nTexas, and any disputes related to PARTNERPRO services will be handled\nin courts located in Texas. Our services are operated from Texas, and we\nmake no claims that they\\\'re suitable for use outside this area.\n\n**18. General:** You agree to comply with export laws when using our\nservices. If any part of these terms is deemed invalid, the rest remains\neffective. We can assign these terms without notifying you, while you\ncannot transfer your rights or assign this agreement. If we choose not\nto act on a violation, it doesn\'t waive our rights for future issues.\nThese terms represent our entire agreement, superseding any prior\ncommunications between you and PARTNERPRO.\n\n**19. Consent to Communications:** By using PARTNERPRO, you agree to\nreceive electronic communications from us, such as notices and\ndisclosures, which satisfy any legal requirements for written\ncommunications. Calls and texts made through PARTNERPRO may be monitored\nor recorded, and you consent to this practice. We may also collect and\nstore call and message details as described in our Privacy Policy.\n\n**20. Notice to California Residents:** If you\\\'re a California\nresident, you can contact the Complaint Assistance Unit of the Division\nof Consumer Services at the California Department of Consumer Affairs\nwith concerns about the service.\n\n**21. Contact Information and License Disclosures:** PARTNERPRO operates\nfrom our headquarters in Frisco Texas. You can reach out to us by\nemailing consumercare@PARTNERPRO.net. Our complete list of licenses and\ndisclosures is available upon request.\n\n**22. Notice to Apple Users:** If you\\\'re using an iOS device, you\nacknowledge that these terms are between you and PARTNERPRO, not Apple.\nApple isn\\\'t responsible for our services or any related claims. If the\nservices fail, Apple\\\'s only obligation is to refund the purchase price\nof the mobile app. You agree to follow third-party terms when using our\nservices on Apple devices, and Apple holds third-party beneficiary\nrights to enforce this section. You also represent that you\\\'re not in a\nrestricted country or listed as a prohibited party under U.S. laws.''',
                            selectable: true,
                            onTapLink: (_, url, __) => launchURL(url!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
