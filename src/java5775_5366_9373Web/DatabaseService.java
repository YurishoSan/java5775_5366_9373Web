/**
 * 
 */
package java5775_5366_9373Web;

import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Arrays;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.codehaus.jackson.map.ObjectMapper;

import com.google.gson.Gson;
import entities.*;
import entities.enums.*;
import entities.json.*;

/**
 * @author Yurisho
 *
 */
public class DatabaseService implements Backend
{
	private final Charset UTF8_CHARSET = Charset.forName("UTF-8");
	public static final String URL = "https://java577553669373.herokuapp.com/api/db/";

	private static final SimpleDateFormat dateFormat = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	
	String decodeUTF8(byte[] bytes)
	{
		return new String(bytes, UTF8_CHARSET);
	}

	byte[] encodeUTF8(String string)
	{
		return string.getBytes(UTF8_CHARSET);
	}

	private String GET(String url)
	{
		InputStream inputStream = null;
		String result = "";

		try
		{
			HttpClient httpclient = new DefaultHttpClient();
			HttpResponse httpResponse = httpclient.execute(new HttpGet(url));
			inputStream = httpResponse.getEntity().getContent();
			if (inputStream != null)
			{
				result = convertInputStreamToString(inputStream);
				byte ptext[] = result.getBytes();
				result = new String(ptext, "UTF-8");
			}
			else
				result = "Did not work!";
		}
		catch (Exception e)
		{
			return e.getMessage();
		}
		return result;
	}

	private String POST(String url, String jsonParamsAsString)
	{
		String result = "";
		try
		{
			DefaultHttpClient httpClient = new DefaultHttpClient();
			HttpPost postRequest = new HttpPost(url);
			StringEntity input = new StringEntity(jsonParamsAsString);
			input.setContentType("application/json; charset=utf-8");
			postRequest.setEntity(input);
			HttpResponse response = httpClient.execute(postRequest);
			result = convertInputStreamToString(response.getEntity()
					.getContent());
			byte ptext[] = result.getBytes();
			result = new String(ptext, "UTF-8");
		}
		catch (Exception e)
		{
			return e.getMessage();
		}
		return result;
	}

	private String convertInputStreamToString(InputStream inputStream)
			throws IOException
	{
		BufferedReader bufferedReader = new BufferedReader(
				new InputStreamReader(inputStream));
		String line = "";
		String result = "";
		while ((line = bufferedReader.readLine()) != null)
			result += line;
		inputStream.close();
		return result;
	}

	@SuppressWarnings("deprecation") // Date is deprecated, should change Date to GeorgianCalender in next version.
	@Override
	public void setLists()
	{
		try
		{
			this.addAllergy(new Allergy(0, "Paracetamol hypersensitivity",
					"������ � ���������, ����� ����� �� �����."));
			this.addAllergy(new Allergy(1, "test",
					"������ � ���������, ����� ����� �� �����."));
			
			this.addDoctor(new Doctor(1, "test", "testy", Gender.MALE, new Date(1970, 5, 12), new Date(2002, 7, 1), 
					"moti_kereker321@yahoo.com", (float)130000.0, "050777654", Specialization.FAMILY));
			this.addDoctor(new Doctor(333658712, "����", "����", Gender.MALE, new Date(1970, 5, 12), new Date(2002, 7, 1), 
					"moti_kereker321@yahoo.com", (float)130000.0, "050777654", Specialization.FAMILY));
			
			this.addMedicine(new Medicine(0, "����� �����",
					"Microcrystalline cellulose, stearic acid, crospovidone, silicon dioxide, hydroxypropyl"
				+	"methylcellulose, FD&C red #40, FD&C yellow #6, polyethylene glycol 400, titanium dioxide,"
				+	"polysorbate 80, purified water. ",
				"Acetylsalicylic acid 250 mg, Paracetamol 250 mg, Caffeine anhydrous 65 mg",
				MedicineType.PILL_TABLET));
			
			this.addMedicineAllergy(new MedicineAllergy(0, 0));
			
			this.addPassword(new Password(1, "1", Permit.DOCTOR));
			this.addPassword(new Password(333658712, "1234", Permit.DOCTOR));
			
			this.addPatient(new Patient(544812123, "�����", "����", Gender.MALE, new Date(1980, 11, 15), "sabamba@gmail.com",
					ServiceClass.GOLD, "035432213"));
			
			//this.addPatientAllergy(patientAllergy);
			
			//this.addPrescription(prescription);
			
			//this.addTreatment(treatment);
			
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

	}

	@Override
	public void addAllergy(Allergy allergy) throws Exception
	{
		Gson gson = new Gson();
		String result = POST(URL + "addAllergy",
				gson.toJson(allergy, Allergy.class));
		if (!result.equals("success"))
			throw new Exception(result);

	}

	@SuppressWarnings("deprecation")
	@Override
	public void addDoctor(Doctor doctor) throws Exception
	{
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.getSerializationConfig().setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
		String result = POST(URL + "addDoctor", objectMapper.writeValueAsString(doctor));
		if (!result.equals("success"))
			throw new Exception(result);

	}

	@Override
	public void addMedicine(Medicine medicine) throws Exception
	{
		Gson gson = new Gson();
		String result = POST(URL + "addMedicine",
				gson.toJson(medicine, Medicine.class));
		if (!result.equals("success"))
			throw new Exception(result);

	}

	@Override
	public void addMedicineAllergy(MedicineAllergy medicineAllergy)
			throws Exception
	{
		Gson gson = new Gson();
		String result = POST(URL + "addMedicineAllergy",
				gson.toJson(medicineAllergy, MedicineAllergy.class));
		if (!result.equals("success"))
			throw new Exception(result);

	}

	@Override
	public void addPassword(Password password) throws Exception
	{
		Gson gson = new Gson();
		String result = POST(URL + "addPassword",
				gson.toJson(password, Password.class));
		if (!result.equals("success"))
			throw new Exception(result);

	}

	@SuppressWarnings("deprecation")
	@Override
	public void addPatient(Patient patient) throws Exception
	{
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.getSerializationConfig().setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
		String result = POST(URL + "addPatient", objectMapper.writeValueAsString(patient));
		if (!result.equals("success"))
			throw new Exception(result);

	}

	@Override
	public void addPatientAllergy(PatientAllergy patientAllergy)
			throws Exception
	{
		Gson gson = new Gson();
		String result = POST(URL + "addPatientAllergy",
				gson.toJson(patientAllergy, PatientAllergy.class));
		if (!result.equals("success"))
			throw new Exception(result);

	}

	@SuppressWarnings("deprecation")
	@Override
	public void addPrescription(Prescription prescription) throws Exception
	{
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.getSerializationConfig().setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
		String result = POST(URL + "addPrescription", objectMapper.writeValueAsString(prescription));
		if (!result.equals("success"))
			throw new Exception(result);

	}

	@SuppressWarnings("deprecation")
	@Override
	public void addTreatment(Treatment treatment) throws Exception
	{
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.getSerializationConfig().setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
		String result = POST(URL + "addTreatment", objectMapper.writeValueAsString(treatment));
		if (!result.equals("success"))
			throw new Exception(result);

	}

	@Override
	public void deleteAllergy(long allergyID) throws Exception
	{
		String result = GET(URL + "deleteAllergyByID?allergyID=" + allergyID);
		if (!result.equals("success"))
			throw new Exception("Connection Problems " + result);

	}

	@Override
	public void deleteDoctor(long doctorID) throws Exception
	{
		String result = GET(URL + "deleteDoctorByID?doctorID=" + doctorID);
		if (!result.equals("success"))
			throw new Exception("Connection Problems " + result);

	}

	@Override
	public void deleteMedicine(long medicineID) throws Exception
	{
		String result = GET(URL + "deleteMedicineByID?medicineID=" + medicineID);
		if (!result.equals("success"))
			throw new Exception("Connection Problems " + result);

	}

	@Override
	public void deletePatient(long patientID) throws Exception
	{
		String result = GET(URL + "deletePatientByID?patientID=" + patientID);
		if (!result.equals("success"))
			throw new Exception("Connection Problems " + result);

	}

	@Override
	public void deleteTreatment(long treatmentID) throws Exception
	{
		String result = GET(URL + "deleteTreatmentByID?treatmentID="
				+ treatmentID);
		if (!result.equals("success"))
			throw new Exception("Connection Problems " + result);

	}

	@Override
	public void deleteMedicineAllergyByAllergy(long allergyID) throws Exception
	{
		String result = GET(URL + "deleteMedicineAllergyByAllergy?allergyID="
				+ allergyID);
		if (!result.equals("success"))
			throw new Exception("Connection Problems " + result);

	}

	@Override
	public void deleteMedicineAllergyByMedicine(long medicineID)
			throws Exception
	{
		String result = GET(URL + "deleteMedicineAllergyByMedicine?medicineID="
				+ medicineID);
		if (!result.equals("success"))
			throw new Exception("Connection Problems " + result);

	}

	@Override
	public void deletePatientAllergyByPatient(long patientID) throws Exception
	{
		String result = GET(URL + "deletePatientAllergyByPatient?patientID="
				+ patientID);
		if (!result.equals("success"))
			throw new Exception("Connection Problems " + result);

	}

	@Override
	public void deletePatientAllergyByAllergy(long allergyID) throws Exception
	{
		String result = GET(URL + "deletePatientAllergyByAllergy?allergyID="
				+ allergyID);
		if (!result.equals("success"))
			throw new Exception("Connection Problems " + result);

	}

	@Override
	public void deletePrescriptionByMedicine(long medicineID) throws Exception
	{
		String result = GET(URL + "deletePrescriptionByMedicine?medicineID="
				+ medicineID);
		if (!result.equals("success"))
			throw new Exception("Connection Problems " + result);

	}

	@Override
	public void deletePrescriptionByTreatment(long treatmentID)
			throws Exception
	{
		String result = GET(URL + "deletePrescriptionByTreatment?treatmentID="
				+ treatmentID);
		if (!result.equals("success"))
			throw new Exception("Connection Problems " + result);

	}

	@Override
	public void updateAllergy(Allergy allergy) throws Exception
	{
		Gson gson = new Gson();
		String result = POST(URL + "updateAllergy",
				gson.toJson(allergy, Allergy.class));
		if (!result.equals("success"))
			throw new Exception(result);

	}

	@SuppressWarnings("deprecation")
	@Override
	public void updateDoctor(Doctor doctor) throws Exception
	{
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.getSerializationConfig().setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
		String result = POST(URL + "updateDoctor", objectMapper.writeValueAsString(doctor));
		if (!result.equals("success"))
			throw new Exception(result);

	}
	
	@Override
	public void updateMedicine(Medicine medicine) throws Exception
	{
		Gson gson = new Gson();
		String result = POST(URL + "updateMedicine",
				gson.toJson(medicine, Medicine.class));
		if (!result.equals("success"))
			throw new Exception(result);

	}

	@Override
	public void updateMedicineAllergy(MedicineAllergy medicineAllergy)
			throws Exception
	{
		Gson gson = new Gson();
		String result = POST(URL + "updateMedicineAllergy",
				gson.toJson(medicineAllergy, MedicineAllergy.class));
		if (!result.equals("success"))
			throw new Exception(result);

	}

	@Override
	public void updatePassword(Password oldPassword, String newPassword)
			throws Exception
	{
		Gson gson = new Gson();
		String result = POST(URL + "updatePassword", gson.toJson(
				new UpdatePasswordArgs(oldPassword, newPassword),
				UpdatePasswordArgs.class));
		if (!result.equals("success"))
			throw new Exception(result);

	}

	@Override
	public void updatePassword(Password oldPassword, String newPassword,
			Permit permit) throws Exception
	{
		Gson gson = new Gson();
		String result = POST(URL + "updatePasswordAndPermit", gson.toJson(
				new UpdatePasswordPermitArgs(oldPassword, newPassword, permit),
				UpdatePasswordPermitArgs.class));
		if (!result.equals("success"))
			throw new Exception(result);

	}

	@SuppressWarnings("deprecation")
	@Override
	public void updatePatient(Patient patient) throws Exception
	{
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.getSerializationConfig().setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
		String result = POST(URL + "updatePatient", objectMapper.writeValueAsString(patient));
		if (!result.equals("success"))
			throw new Exception(result);
	}

	@Override
	public void updatePatientAllergy(PatientAllergy patientAllergy)
			throws Exception
	{
		Gson gson = new Gson();
		String result = POST(URL + "updatePatientAllergy",
				gson.toJson(patientAllergy, PatientAllergy.class));
		if (!result.equals("success"))
			throw new Exception(result);

	}

	@SuppressWarnings("deprecation")
	@Override
	public void updatePrescription(Prescription prescription) throws Exception
	{
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.getSerializationConfig().setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
		String result = POST(URL + "updatePrescription", objectMapper.writeValueAsString(prescription));
		if (!result.equals("success"))
			throw new Exception(result);
	}

	@SuppressWarnings("deprecation")
	@Override
	public void updateTreatment(Treatment treatment) throws Exception
	{
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.getSerializationConfig().setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
		String result = POST(URL + "updateTreatment", objectMapper.writeValueAsString(treatment));
		if (!result.equals("success"))
			throw new Exception(result);
	}

	@Override
	public ArrayList<Allergy> getAllergyList() throws Exception
	{
		Gson gson;
		String result = GET(URL + "getAllergyList");
		gson = new Gson();
		return new ArrayList<Allergy>(Arrays.asList(gson.fromJson(result,
				Allergy[].class)));
	}

	@Override
	public ArrayList<Allergy> getAllergyByPatientList(long patientID)
			throws Exception
	{
		Gson gson = new Gson();
		String result = GET(URL + "getAllergyByPatientList?patientID="
				+ patientID);
		return new ArrayList<Allergy>(Arrays.asList(gson.fromJson(result,
				Allergy[].class)));
	}

	@Override
	public ArrayList<Allergy> getAllergyByMedicineList(long medicineID)
			throws Exception
	{
		Gson gson = new Gson();
		String result = GET(URL + "getAllergyByMedicineList?medicineID="
				+ medicineID);
		return new ArrayList<Allergy>(Arrays.asList(gson.fromJson(result,
				Allergy[].class)));
	}

	@SuppressWarnings("deprecation")
	@Override
	public ArrayList<Doctor> getDoctorList() throws Exception
	{
		ObjectMapper objectMapper = new ObjectMapper();
		String result = GET(URL + "getDoctorList");
		objectMapper.getDeserializationConfig().setDateFormat(dateFormat);
		return new ArrayList<Doctor>(Arrays.asList(objectMapper.readValue(result, Doctor[].class)));
	}

	@Override
	public ArrayList<Medicine> getMedicineList() throws Exception
	{
		Gson gson = new Gson();
		String result = GET(URL + "getMedicineList");
		return new ArrayList<Medicine>(Arrays.asList(gson.fromJson(result,
				Medicine[].class)));
	}

	@Override
	public ArrayList<Medicine> getMedicineByTreatmentList(long treatmentID)
			throws Exception
	{
		Gson gson = new Gson();
		String result = GET(URL + "getMedicineByTreatmentList?treatmentID="
				+ treatmentID);
		return new ArrayList<Medicine>(Arrays.asList(gson.fromJson(result,
				Medicine[].class)));
	}

	@SuppressWarnings("deprecation")
	@Override
	public ArrayList<Patient> getPatientList() throws Exception
	{
		ObjectMapper objectMapper = new ObjectMapper();
		String result = GET(URL + "getPatientList");
		objectMapper.getDeserializationConfig().setDateFormat(dateFormat);
		return new ArrayList<Patient>(Arrays.asList(objectMapper.readValue(result, Patient[].class)));
	}

	@Override
	public MedicineAllergy getConectorMedicineAllergy(long medicineID,
			long allergyID) throws Exception
	{
		Gson gson = new Gson();
		String result = GET(URL + "getConectorMedicineAllergy?medicineID="
				+ medicineID + "&allergyID=" + allergyID);
		return gson.fromJson(result, MedicineAllergy.class);
	}

	@Override
	public PatientAllergy getConectorPatientAllergy(long patientID,
			long allergyID) throws Exception
	{
		Gson gson = new Gson();
		String result = GET(URL + "getConectorPatientAllergy?patientID="
				+ patientID + "&allergyID=" + allergyID);
		return gson.fromJson(result, PatientAllergy.class);
	}

	@SuppressWarnings("deprecation")
	@Override
	public Prescription getConectorPrescription(long treatmentID,
			long medicineID) throws Exception
	{
		ObjectMapper objectMapper = new ObjectMapper();
		String result = GET(URL + "getConectorPrescription?treatmentID="
				+ treatmentID + "&medicineID=" + medicineID);
		objectMapper.getDeserializationConfig().setDateFormat(dateFormat);
		return objectMapper.readValue(result, Prescription.class);
	}

	@Override
	public Permit checkPassword(long loginID, String password) throws Exception
	{
		Gson gson = new Gson();
		String result = GET(URL + "checkPassword?loginID="
				+ loginID + "&password=" + password);
		return gson.fromJson(result, Permit.class);
	}

	@Override
	public boolean isEmpty() throws Exception
	{
		Gson gson = new Gson();
		String result = GET(URL + "isEmpty");
		return gson.fromJson(result, boolean.class);
	}

}