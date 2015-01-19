<%@page import="java5775_5366_9373Web.BackendFactory"%>
<%@page import="entities.Allergy"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<title>הוסף אלרגיה</title>
</head>
<body>
	<form>
	<h1 style="text-align: center;">הוסף אלרגיה</h1>

		<table align="center" border="1" cellpadding="1" cellspacing="1"
			style="width: 500px;">
			<tbody>
				<tr>
					<td style="text-align: center;"><input name="allergyName"
						style="width: 100%" type="text" /></td>
					<td style="text-align: right; width: 100px">שם אלרגיה</td>
				</tr>
				<tr>
					<td style="text-align: center;"><textarea name="allergyNotes"
							rows="5" style="width: 100%"></textarea></td>
					<td style="text-align: right; width: 100px">הערות</td>
				</tr>
			</tbody>
		</table>

		<div align="center">&nbsp;</div>

		<div align="center">
			<input type="submit" value="אישור" />
		</div>
		<%
			String allergyName = request.getParameter("allergyName");
			String allergyNotes = request.getParameter("allergyNotes");

			if (allergyName != null && allergyName != ""
					&& allergyNotes != null && allergyNotes != "")
			{
				try
				{
					Allergy allergy = new Allergy(0, allergyName, allergyNotes);
					BackendFactory.getInstance().addAllergy(allergy);
					response.sendRedirect("index.html");
					out.print("good");
				}
				catch (Exception e)
				{
					out.print(e.getMessage());
				}
			}
			else
			{
				out.print("נא למלא את כל השדות!");
			}
		%>
	</form>
</body>
</html>
