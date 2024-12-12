using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Newtonsoft.Json;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json.Linq;
using System.Text.RegularExpressions;
using System.Text;
using System.Text.Json;
using JsonException = Newtonsoft.Json.JsonException;

namespace JSON
{
    public partial class Example : System.Web.UI.Page
    {


        private static readonly HttpClient client = new HttpClient();
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected async void btnConvert_Click(object sender, EventArgs e)
        {
            try
            {
                string ticketText = txtjsontext.Text;
                string q2 = await GetQuotationJSon(ticketText);
                txtJsonOutput.Text = q2;
            }
            catch (Exception ex)
            {
                txtJsonOutput.Text = $"Error: {ex.Message}";
            }

        }






        public static async Task<string> GetQuotationJSon(string ticketText)
        {
            string jsonResponse = await GetGeminiResponse(ticketText);


            var jsonObject = JsonConvert.DeserializeObject<dynamic>(jsonResponse);


            // Deserialize the JSON string into a JArray
            JArray jsonArray = JArray.Parse(jsonResponse);

            // Access the "text" attribute
            string textJson = jsonArray[0]["content"]["parts"][0]["text"].ToString();

            // Output the value
            Console.WriteLine("Text JSON: " + textJson);


            // Step 1: Remove ```json and ```
            string clean = Regex.Replace(textJson, @"^```json|```$", "", RegexOptions.Multiline).Trim();

            // Step 2: Remove comments (lines with // or /** Note:**)
            clean = Regex.Replace(clean, @"//.*|/\*\*.*?\*/", "");



            //clean = Regex.Replace(clean, @"OperatingAirline", "OperatingCarrier");
            //clean = Regex.Replace(clean, @"Remarks", "Notes");

            //// Step 4: Handle baggage format consistency (e.g., "40KG" -> {"weight": 40, "unit": "KG"})
            //clean = Regex.Replace(clean, @"(\d+)(KG|PC)", @"{ ""weight"": $1, ""unit"": ""$2"" }");

            //// Step 5: Optional: Add currency if needed, or set it to a default value (USD in this case)
            //clean = Regex.Replace(clean, @"\""\bCurrency\b\"": ""\b""", "\"Currency\": \"USD\"");


            return clean;
        }



        

        private static JObject ParseBaggage(JToken baggageToken)
        {
            // If baggage is in the format like "40KG", split it into weight and unit
            if (baggageToken != null && baggageToken.ToString().Contains("KG"))
            {
                string baggage = baggageToken.ToString();
                var match = Regex.Match(baggage, @"(\d+)(KG|PC)");
                if (match.Success)
                {
                    return new JObject
            {
                { "weight", int.Parse(match.Groups[1].Value) },
                { "unit", match.Groups[2].Value }
            };
                }
            }
            return new JObject { { "weight", 0 }, { "unit", "KG" } }; // default case
        }



        public static async Task<string> GetGeminiResponse(string ticketText)

        {

            // Define the API URL

            string apiUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=AIzaSyAlxvR9sXEsPFwK7m6g5sK93V_7ZloXmUY";

            // Define the request body (payload)

            //string ticketText = "1.ALHINSHEERI/ALHARITH FATHI OMAR MR^2 H16640 Y 02DEC 1 MJIIST HK1 2200 0230 03DEC E H1/^ OPERATED BY LIBYAN WINGS AIRLINE^3 TK 900 H 03DEC 2 ISTPTY HK1 0910 1820 03DEC E TK/^h1 NONR EF31705 TAXES 15388 BAG 40KG^TK SEMN FARE 172771 TAXES 16487 BAG 2PC^CXXED590";

            // Ensure ticketText is properly escaped

            ticketText = ticketText.Replace("\"", "\\\"");

            // Define the payload, embedding ticketText

            string payload = $"{{\"contents\":[{{\"parts\":[{{\"text\":\"Convert this galileo ticket quotation to JSON format. Get only the attributes and values. Provide names for Airports, Currency {ticketText}\"}}]}}]}}";

            // Convert payload to JSON

            var jsonContent = new StringContent(payload, Encoding.UTF8, "application/json");


            // Send the POST request

            var response = await client.PostAsync(apiUrl, jsonContent);

            if (response.IsSuccessStatusCode)

            {

                // Parse the response

                var responseContent = await response.Content.ReadAsStringAsync();

                // Transform the response to a JSON object

                try

                {

                    // Use System.Text.Json to parse the JSON response

                    using (JsonDocument document = JsonDocument.Parse(responseContent))

                    {

                        JsonElement root = document.RootElement;

                        if (root.TryGetProperty("candidates", out JsonElement candidates))

                        {

                            // Return the formatted JSON as a string

                            return candidates.ToString();

                        }

                    }

                }

                catch (System.Text.Json.JsonException ex)

                {

                    throw new Exception("Failed to parse JSON response: " + ex.Message);

                }

            }

            else

            {

                // Handle failure

                throw new Exception("Error in response: " + response.StatusCode);

            }

            return string.Empty;

        }







    }
}







