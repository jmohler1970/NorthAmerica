<!---
The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
--->


<cfscript>
param url.format = "html";

string function getMyData () output="false" {

	return SerializeJSON(QueryExecute("
		SELECT *
		FROM dbo.StatesProvinces
		ORDER BY CountrySort, LongName
		",[],
		{datasource : "Sample"}
		), "struct");
} // end function

if(url.format == "JSON")	{

	cfheader(name="Content-Type", value="application/json");
	cfsetting(showDebugOutput = false);
	writeOutput(getMyData());
	exit;
	}
</cfscript>



<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>ColdFusion SQL Sample Page</title>

	<link rel="stylesheet" href="https://unpkg.com/buefy/dist/buefy.min.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" crossorigin="anonymous">

	<script src="https://unpkg.com/vue@2.5.17"></script>
	<script src="https://unpkg.com/buefy@0.6.7"></script>
	<script src="https://unpkg.com/axios@0.18.0/dist/axios.min.js"></script>

</head>
<body>

	<div id="app">

	<section class="hero is-info">
		<div class="hero-body">
			<div class="container">
				<h1 class="title">
					ColdFusion SQL Sample Page
				</h1>
				<h2 class="subtitle">
					By James Mohler
				</h2>
			</div>
		</div>
	</section>


	<section class="section">
		<div class="container">

			<b-table :data="myStatesProvinces" :loading="loading">
				<template slot-scope="props">
					<b-table-column field="ID" label="ID" numeric>
						{{ props.row.ID }}
					</b-table-column>

					<b-table-column field="COUNTRY" label="Country">
						{{ props.row.COUNTRY }}
					</b-table-column>

					<b-table-column field="LONGNAME" label="Name">
						{{ props.row.LONGNAME }}
					</b-table-column>
				</template>
			</b-table>

		</div><!--/ container -->
	</section>

	</div><!--- /end VueJS --->

	<script>
		new Vue({
			el: '#app',
			data () { 
				return {
					loading : false,
					myStatesProvinces : []
				}
			},

			watch: {
				path: function () {
					this.getStatesProvinces();
				}
			},

			mounted () {
				this.getStatesProvinces();
			},

			methods: {
				getStatesProvinces : function()	{
					this.loading = true;
					axios
						.get('?format=json')
						.then(response => (this.myStatesProvinces = response.data))
						.catch(error => {
							console.log(error)
							});
					this.loading = false;
				}
			}
		});
	</script>

</body>
</html>