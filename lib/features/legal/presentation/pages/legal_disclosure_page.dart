import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LegalDisclosurePage extends StatelessWidget {
  const LegalDisclosurePage({super.key});

  static const _disclosureMarkdown = '''## LEGAL DISCLOSURE

**PartnerPro** is a licensed real estate brokerage designed exclusively to support real estate agents in expanding and managing their business. PartnerPro does not replace an agent's primary brokerage, and agents may not hang their license with PartnerPro. Instead, PartnerPro provides tools and operational support that allow agents to grow and manage their business anywhere within the state(s) where they hold an active real estate license.

**PartnerPro** does not provide agency representation, legal advice, or negotiation services to consumers. All client relationships, fiduciary duties, compliance obligations, and adherence to state-specific licensing laws remain the sole responsibility of the agent.

Agents subscribe to **PartnerPro** for a **\$49 monthly fee**, which provides access to platform tools and business-expansion resources. Client showings are coordinated through an independent third-party service at a rate of **\$50 per showing**. **Transaction Coordinator (TC)** services are billed at closing at a rate of **\$450 per transaction file**.

**PartnerPro** supports business continuity for agents—including during travel or vacation—by offering systems for communication, scheduling, and transaction coordination. **All fees are non-refundable** and exclude any third-party costs.''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Legal Disclosures')),
      body: Markdown(
        data: _disclosureMarkdown,
        selectable: true,
        padding: EdgeInsets.all(16.w),
      ),
    );
  }
}
