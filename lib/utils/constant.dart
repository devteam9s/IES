class Constants{
  static String BaseUrl="";
  static String apiKey="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyAgCiAgICAicm9sZSI6ICJzZXJ2aWNlX3JvbGUiLAogICAgImlzcyI6ICJzdXBhYmFzZS1kZW1vIiwKICAgICJpYXQiOiAxNjQxNzY5MjAwLAogICAgImV4cCI6IDE3OTk1MzU2MDAKfQ.DaYlNEoUrrEn2Ig7tqibS-PHK5vgusbcbo7X36XVt4Q";
  static String bearerToken="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyAgCiAgICAicm9sZSI6ICJzZXJ2aWNlX3JvbGUiLAogICAgImlzcyI6ICJzdXBhYmFzZS1kZW1vIiwKICAgICJpYXQiOiAxNjQxNzY5MjAwLAogICAgImV4cCI6IDE3OTk1MzU2MDAKfQ.DaYlNEoUrrEn2Ig7tqibS-PHK5vgusbcbo7X36XVt4Q";

  static String CUSTOMER_ID = "CustomerId";
}

class ApiEndPoints{

//real ip: 13.51.198.7:8000

//test ip 13.127.224.146:8000

  static String BaseUrl="http://13.51.198.7:8000";
  static String login="$BaseUrl/rest/v1/rpc/loginfunc";
  static String customerSystems="$BaseUrl/rest/v1/rpc/get_customer_systems";
  static String adminSystems="$BaseUrl/rest/v1/rpc/get_systems";
  static String customerSensors="$BaseUrl/rest/v1/rpc/get_sensors";
  static String userDashBoardData="$BaseUrl/rest/v1/rpc/user_customer_dashboard";
  static String useadminDashBoardData="$BaseUrl/rest/v1/rpc/admin_dashboard";
  static String addSystem="$BaseUrl/rest/v1/rpc/add_systems";
  static String addSensors="$BaseUrl/rest/v1/rpc/add_sensors";
  static String sendDeviceID="$BaseUrl/rest/v1/rpc/insert_update_register_entry";
  static String getCustomerList="$BaseUrl/rest/v1/rpc/get_customer_list";
  static String changeOtp="$BaseUrl/rest/v1/rpc/reset_password";
  static String raiseComplaint = "$BaseUrl/rest/v1/rpc/raise_ticket";
  static String getComplaints = "$BaseUrl/rest/v1/rpc/get_tickets";
  static String getAdminComplaints = "$BaseUrl/rest/v1/rpc/get_tickets_by_customer_id";
  static String updateStatusOfTicket = "$BaseUrl/rest/v1/rpc/update_ticket_status_by_admin";
  static String getReportGenerated = "$BaseUrl/rest/v1/rpc/get_filtered_reports";
  static String getNotificationList = "$BaseUrl/rest/v1/rpc/get_recent_notifications";
  static String getNotificationFlag = "$BaseUrl/rest/v1/rpc/get_flag_status_for_operator";
  static String getPitStatus = "$BaseUrl/rest/v1/rpc/get_pits";
  static String getMqttRestApiData = "$BaseUrl/rest/v1/rpc/get_new_server_data";


}