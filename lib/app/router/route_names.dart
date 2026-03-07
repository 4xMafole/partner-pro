/// Centralized route path constants.
abstract final class RouteNames {
  // ── Auth ──
  static const onboard = '/auth/onboard';
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const forgotPassword = '/auth/forgot-password';
  static const roleSelection = '/auth/role-selection';

  // ── Legal ──
  static const legalDisclosure = '/legal/disclosure';
  static const termsOfUse = '/legal/terms';
  static const communicationConsent = '/legal/communication-consent';

  // ── Onboarding ──
  static const onboardingForm = '/onboarding/form';

  // ── Buyer Shell ──
  static const buyerDashboard = '/buyer/dashboard';
  static const buyerSearch = '/buyer/search';
  static const myHomes = '/buyer/my-homes';
  static const buyerTools = '/buyer/tools';
  static const buyerProfile = '/buyer/profile';

  // ── Agent Shell ──
  static const agentDashboard = '/agent/dashboard';
  static const agentSearch = '/agent/search';
  static const agentOffers = '/agent/offers';
  static const agentClients = '/agent/clients';
  static const agentProfile = '/agent/profile';

  // ── Standalone ──
  static const propertyDetails = '/property/:id';
  static const offerDetails = '/offer/:id';
  static const editProfile = '/profile/edit';
  static const settings = '/settings';
  static const security = '/settings/security';
  static const notificationSettings = '/settings/notifications';
  static const notifications = '/notifications';
  static const storeDocuments = '/documents';
  static const pdfViewer = '/pdf-viewer';
  static const proofFunds = '/tools/proof-funds';
  static const preapprovals = '/tools/preapprovals';
  static const signContract = '/contract/:id/sign';
  static const signaturePage = '/signature';
  static const scheduledShowings = '/showings';
  static const subscription = '/subscription';
  static const agentSubscription = '/agent/subscription';
  static const agentInvite = '/agent/invite';
  static const buyerChat = '/buyer/chat';
}
