﻿#language: en
@tree
@Positive
@Movements
@MovementsSalesReportFromTradeAgent


Feature: check sales report from trade agent movements

Variables:
import "Variables.feature"

Background:
	Given I launch TestClient opening script or connect the existing one



Scenario: _046000 preparation (sales report from trade agent)
	When set True value to the constant
	When set True value to the constant Use commission trading
	And I close TestClient session
	Given I open new TestClient session or connect the existing one
	* Load info
		When Create catalog ObjectStatuses objects
		When Create catalog ItemKeys objects
		When Create catalog ItemTypes objects (serial lot numbers)
		When Create catalog Items objects (serial lot numbers)
		When Create catalog ItemKeys objects (serial lot numbers)
		When Create information register Barcodes records (serial lot numbers)
		When Create catalog SerialLotNumbers objects (serial lot numbers)
		When Create catalog ItemTypes objects
		When Create catalog Units objects
		When Create catalog Items objects
		When Create catalog PriceTypes objects
		When Create catalog Specifications objects
		When Create catalog Partners objects (trade agent and consignor)
		When Create chart of characteristic types AddAttributeAndProperty objects
		When Create catalog AddAttributeAndPropertySets objects
		When Create catalog AddAttributeAndPropertyValues objects
		When Create catalog Currencies objects
		When Create catalog Companies objects (Main company)
		When Create catalog Stores objects
		When Create catalog Stores (trade agent)
		When Create catalog Partners objects (Ferron BP)
		When Create catalog Companies objects (partners company)
		When Create information register PartnerSegments records
		When Create catalog PartnerSegments objects
		When Create catalog Agreements objects
		When Create chart of characteristic types CurrencyMovementType objects
		When Create catalog TaxRates objects
		When Create catalog Taxes objects	
		When Create information register TaxSettings records
		When Create information register PricesByItemKeys records
		When Create catalog IntegrationSettings objects
		When Create information register CurrencyRates records
		When Create catalog BusinessUnits objects
		When Create catalog ExpenseAndRevenueTypes objects
		When update ItemKeys
		When Create catalog Partners objects
		When Data preparation (comission stock)
		When Create catalog Companies objects (own Second company)
	* Add plugin for taxes calculation
		Given I open hyperlink "e1cib/list/Catalog.ExternalDataProc"
		If "List" table does not contain lines Then
				| "Description" |
				| "TaxCalculateVAT_TR" |
			When add Plugin for tax calculation
		When Create information register Taxes records (VAT)
		When Create catalog Partners objects (Kalipso)
	* Tax settings
		When filling in Tax settings for company
	* Post document
		And I execute 1C:Enterprise script at server
 			| "Documents.PurchaseInvoice.FindByNumber(192).GetObject().Write(DocumentWriteMode.Posting);" |
	* Setting for Company
		When settings for Company (commission trade)
	* LoadDocuments
		When Create document PurchaseInvoice objects (comission trade, consignment)
		When Create document SalesInvoice objects (comission trade, consignment)
		When Create document SalesReturn objects (comission trade, consignment)
		When Create document SalesReportFromTradeAgent objects (movements)
	* Post document
		* Posting Purchase invoice
			And I execute 1C:Enterprise script at server
				| "Documents.PurchaseInvoice.FindByNumber(192).GetObject().Write(DocumentWriteMode.Posting);" |	
			And I execute 1C:Enterprise script at server
				| "Documents.PurchaseInvoice.FindByNumber(193).GetObject().Write(DocumentWriteMode.Posting);" |
			And I execute 1C:Enterprise script at server
				| "Documents.PurchaseInvoice.FindByNumber(194).GetObject().Write(DocumentWriteMode.Posting);" |		
		* Posting SalesInvoice
			And I execute 1C:Enterprise script at server
				| "Documents.SalesInvoice.FindByNumber(192).GetObject().Write(DocumentWriteMode.Posting);" |	
			And I execute 1C:Enterprise script at server
				| "Documents.SalesInvoice.FindByNumber(193).GetObject().Write(DocumentWriteMode.Posting);" |	
		* Posting SalesReturn
			And I execute 1C:Enterprise script at server
				| "Documents.SalesReturn.FindByNumber(192).GetObject().Write(DocumentWriteMode.Posting);" |
		* Posting SalesReportFromTradeAgent
			And I execute 1C:Enterprise script at server
				| "Documents.SalesReportFromTradeAgent.FindByNumber(1).GetObject().Write(DocumentWriteMode.Posting);" |
			And I execute 1C:Enterprise script at server
				| "Documents.SalesReportFromTradeAgent.FindByNumber(2).GetObject().Write(DocumentWriteMode.Posting);" |
	And I close all client application windows

Scenario: _046001 check preparation
	When check preparation

Scenario: _046002 check Sales report from trade agent movements by the Register  "R2001 Sales"
		And I close all client application windows
	* Select Sales report from trade agent
		Given I open hyperlink "e1cib/list/Document.SalesReportFromTradeAgent"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
	* Check movements by the Register  "R2001 Sales"
		And I click "Registrations report" button
		And I select "R2001 Sales" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | ''                    | ''          | ''       | ''           | ''              | ''             | ''                        | ''                             | ''         | ''                                                          | ''         | ''                                     | ''             |
			| 'Document registrations records'                            | ''                    | ''          | ''       | ''           | ''              | ''             | ''                        | ''                             | ''         | ''                                                          | ''         | ''                                     | ''             |
			| 'Register  "R2001 Sales"'                                   | ''                    | ''          | ''       | ''           | ''              | ''             | ''                        | ''                             | ''         | ''                                                          | ''         | ''                                     | ''             |
			| ''                                                          | 'Period'              | 'Resources' | ''       | ''           | ''              | 'Dimensions'   | ''                        | ''                             | ''         | ''                                                          | ''         | ''                                     | ''             |
			| ''                                                          | ''                    | 'Quantity'  | 'Amount' | 'Net amount' | 'Offers amount' | 'Company'      | 'Branch'                  | 'Multi currency movement type' | 'Currency' | 'Invoice'                                                   | 'Item key' | 'Row key'                              | 'Sales person' |
			| ''                                                          | '03.11.2022 10:53:35' | '1'         | '34,24'  | '34,24'      | ''              | 'Main Company' | 'Distribution department' | 'Reporting currency'           | 'USD'      | 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | 'PZU'      | 'c8bc1fbd-3764-4658-b8ed-d200b9e40e0e' | ''             |
			| ''                                                          | '03.11.2022 10:53:35' | '1'         | '200'    | '200'        | ''              | 'Main Company' | 'Distribution department' | 'Local currency'               | 'TRY'      | 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | 'PZU'      | 'c8bc1fbd-3764-4658-b8ed-d200b9e40e0e' | ''             |
			| ''                                                          | '03.11.2022 10:53:35' | '1'         | '200'    | '200'        | ''              | 'Main Company' | 'Distribution department' | 'TRY'                          | 'TRY'      | 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | 'PZU'      | 'c8bc1fbd-3764-4658-b8ed-d200b9e40e0e' | ''             |
			| ''                                                          | '03.11.2022 10:53:35' | '1'         | '200'    | '200'        | ''              | 'Main Company' | 'Distribution department' | 'en description is empty'      | 'TRY'      | 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | 'PZU'      | 'c8bc1fbd-3764-4658-b8ed-d200b9e40e0e' | ''             |
			| ''                                                          | '03.11.2022 10:53:35' | '2'         | '71,9'   | '71,9'       | ''              | 'Main Company' | 'Distribution department' | 'Reporting currency'           | 'USD'      | 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | 'UNIQ'     | '893e35ad-5a64-4039-bd9e-9b987e6f8fca' | ''             |
			| ''                                                          | '03.11.2022 10:53:35' | '2'         | '178,05' | '178,05'     | ''              | 'Main Company' | 'Distribution department' | 'Reporting currency'           | 'USD'      | 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | 'XS/Blue'  | '00f17e8c-56fc-4dfa-a313-36d9337c11b6' | ''             |
			| ''                                                          | '03.11.2022 10:53:35' | '2'         | '420'    | '420'        | ''              | 'Main Company' | 'Distribution department' | 'Local currency'               | 'TRY'      | 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | 'UNIQ'     | '893e35ad-5a64-4039-bd9e-9b987e6f8fca' | ''             |
			| ''                                                          | '03.11.2022 10:53:35' | '2'         | '420'    | '420'        | ''              | 'Main Company' | 'Distribution department' | 'TRY'                          | 'TRY'      | 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | 'UNIQ'     | '893e35ad-5a64-4039-bd9e-9b987e6f8fca' | ''             |
			| ''                                                          | '03.11.2022 10:53:35' | '2'         | '420'    | '420'        | ''              | 'Main Company' | 'Distribution department' | 'en description is empty'      | 'TRY'      | 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | 'UNIQ'     | '893e35ad-5a64-4039-bd9e-9b987e6f8fca' | ''             |
			| ''                                                          | '03.11.2022 10:53:35' | '2'         | '1 040'  | '1 040'      | ''              | 'Main Company' | 'Distribution department' | 'Local currency'               | 'TRY'      | 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | 'XS/Blue'  | '00f17e8c-56fc-4dfa-a313-36d9337c11b6' | ''             |
			| ''                                                          | '03.11.2022 10:53:35' | '2'         | '1 040'  | '1 040'      | ''              | 'Main Company' | 'Distribution department' | 'TRY'                          | 'TRY'      | 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | 'XS/Blue'  | '00f17e8c-56fc-4dfa-a313-36d9337c11b6' | ''             |
			| ''                                                          | '03.11.2022 10:53:35' | '2'         | '1 040'  | '1 040'      | ''              | 'Main Company' | 'Distribution department' | 'en description is empty'      | 'TRY'      | 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | 'XS/Blue'  | '00f17e8c-56fc-4dfa-a313-36d9337c11b6' | ''             |		
		And I close all client application windows

Scenario: _046002 check Sales report from trade agent movements by the Register  "R2021 Customer transactions"
		And I close all client application windows
	* Select Sales report from trade agent
		Given I open hyperlink "e1cib/list/Document.SalesReportFromTradeAgent"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
	* Check movements by the Register  "R2021 Customer transactions"
		And I click "Registrations report" button
		And I select "R2021 Customer transactions" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | ''            | ''                    | ''          | ''             | ''                        | ''                             | ''         | ''              | ''              | ''                           | ''      | ''      | ''                     | ''                           |
			| 'Document registrations records'                            | ''            | ''                    | ''          | ''             | ''                        | ''                             | ''         | ''              | ''              | ''                           | ''      | ''      | ''                     | ''                           |
			| 'Register  "R2021 Customer transactions"'                   | ''            | ''                    | ''          | ''             | ''                        | ''                             | ''         | ''              | ''              | ''                           | ''      | ''      | ''                     | ''                           |
			| ''                                                          | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''                        | ''                             | ''         | ''              | ''              | ''                           | ''      | ''      | 'Attributes'           | ''                           |
			| ''                                                          | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'                  | 'Multi currency movement type' | 'Currency' | 'Legal name'    | 'Partner'       | 'Agreement'                  | 'Basis' | 'Order' | 'Deferred calculation' | 'Customers advances closing' |
			| ''                                                          | 'Receipt'     | '03.11.2022 10:53:35' | '284,19'    | 'Main Company' | 'Distribution department' | 'Reporting currency'           | 'USD'      | 'Trade agent 1' | 'Trade agent 1' | 'Trade agent partner term 1' | ''      | ''      | 'No'                   | ''                           |
			| ''                                                          | 'Receipt'     | '03.11.2022 10:53:35' | '1 660'     | 'Main Company' | 'Distribution department' | 'Local currency'               | 'TRY'      | 'Trade agent 1' | 'Trade agent 1' | 'Trade agent partner term 1' | ''      | ''      | 'No'                   | ''                           |
			| ''                                                          | 'Receipt'     | '03.11.2022 10:53:35' | '1 660'     | 'Main Company' | 'Distribution department' | 'TRY'                          | 'TRY'      | 'Trade agent 1' | 'Trade agent 1' | 'Trade agent partner term 1' | ''      | ''      | 'No'                   | ''                           |
			| ''                                                          | 'Receipt'     | '03.11.2022 10:53:35' | '1 660'     | 'Main Company' | 'Distribution department' | 'en description is empty'      | 'TRY'      | 'Trade agent 1' | 'Trade agent 1' | 'Trade agent partner term 1' | ''      | ''      | 'No'                   | ''                           |		
		And I close all client application windows

Scenario: _046003 check Sales report from trade agent movements by the Register  "R2021 Customer transactions"
		And I close all client application windows
	* Select Sales report from trade agent
		Given I open hyperlink "e1cib/list/Document.SalesReportFromTradeAgent"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
	* Check movements by the Register  "R2021 Customer transactions"
		And I click "Registrations report" button
		And I select "R2021 Customer transactions" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | ''            | ''                    | ''          | ''             | ''                        | ''                             | ''         | ''              | ''              | ''                           | ''      | ''      | ''                     | ''                           |
			| 'Document registrations records'                            | ''            | ''                    | ''          | ''             | ''                        | ''                             | ''         | ''              | ''              | ''                           | ''      | ''      | ''                     | ''                           |
			| 'Register  "R2021 Customer transactions"'                   | ''            | ''                    | ''          | ''             | ''                        | ''                             | ''         | ''              | ''              | ''                           | ''      | ''      | ''                     | ''                           |
			| ''                                                          | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''                        | ''                             | ''         | ''              | ''              | ''                           | ''      | ''      | 'Attributes'           | ''                           |
			| ''                                                          | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'                  | 'Multi currency movement type' | 'Currency' | 'Legal name'    | 'Partner'       | 'Agreement'                  | 'Basis' | 'Order' | 'Deferred calculation' | 'Customers advances closing' |
			| ''                                                          | 'Receipt'     | '03.11.2022 10:53:35' | '284,19'    | 'Main Company' | 'Distribution department' | 'Reporting currency'           | 'USD'      | 'Trade agent 1' | 'Trade agent 1' | 'Trade agent partner term 1' | ''      | ''      | 'No'                   | ''                           |
			| ''                                                          | 'Receipt'     | '03.11.2022 10:53:35' | '1 660'     | 'Main Company' | 'Distribution department' | 'Local currency'               | 'TRY'      | 'Trade agent 1' | 'Trade agent 1' | 'Trade agent partner term 1' | ''      | ''      | 'No'                   | ''                           |
			| ''                                                          | 'Receipt'     | '03.11.2022 10:53:35' | '1 660'     | 'Main Company' | 'Distribution department' | 'TRY'                          | 'TRY'      | 'Trade agent 1' | 'Trade agent 1' | 'Trade agent partner term 1' | ''      | ''      | 'No'                   | ''                           |
			| ''                                                          | 'Receipt'     | '03.11.2022 10:53:35' | '1 660'     | 'Main Company' | 'Distribution department' | 'en description is empty'      | 'TRY'      | 'Trade agent 1' | 'Trade agent 1' | 'Trade agent partner term 1' | ''      | ''      | 'No'                   | ''                           |		
		And I close all client application windows

Scenario: _046004 check Sales report from trade agent movements by the Register  "R4050 Stock inventory"
		And I close all client application windows
	* Select Sales report from trade agent
		Given I open hyperlink "e1cib/list/Document.SalesReportFromTradeAgent"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
	* Check movements by the Register  "R4050 Stock inventory"
		And I click "Registrations report" button
		And I select "R4050 Stock inventory" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | ''            | ''                    | ''          | ''             | ''                  | ''         |
			| 'Document registrations records'                            | ''            | ''                    | ''          | ''             | ''                  | ''         |
			| 'Register  "R4050 Stock inventory"'                         | ''            | ''                    | ''          | ''             | ''                  | ''         |
			| ''                                                          | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''                  | ''         |
			| ''                                                          | ''            | ''                    | 'Quantity'  | 'Company'      | 'Store'             | 'Item key' |
			| ''                                                          | 'Expense'     | '03.11.2022 10:53:35' | '1'         | 'Main Company' | 'Trade agent store' | 'PZU'      |
			| ''                                                          | 'Expense'     | '03.11.2022 10:53:35' | '2'         | 'Main Company' | 'Trade agent store' | 'XS/Blue'  |
			| ''                                                          | 'Expense'     | '03.11.2022 10:53:35' | '2'         | 'Main Company' | 'Trade agent store' | 'UNIQ'     |				
		And I close all client application windows

Scenario: _046005 check Sales report from trade agent movements by the Register  "R5010 Reconciliation statement"
		And I close all client application windows
	* Select Sales report from trade agent
		Given I open hyperlink "e1cib/list/Document.SalesReportFromTradeAgent"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
	* Check movements by the Register  "R5010 Reconciliation statement"
		And I click "Registrations report" button
		And I select "R5010 Reconciliation statement" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | ''            | ''                    | ''          | ''             | ''                        | ''         | ''              | ''                    |
			| 'Document registrations records'                            | ''            | ''                    | ''          | ''             | ''                        | ''         | ''              | ''                    |
			| 'Register  "R5010 Reconciliation statement"'                | ''            | ''                    | ''          | ''             | ''                        | ''         | ''              | ''                    |
			| ''                                                          | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''                        | ''         | ''              | ''                    |
			| ''                                                          | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'                  | 'Currency' | 'Legal name'    | 'Legal name contract' |
			| ''                                                          | 'Receipt'     | '03.11.2022 10:53:35' | '1 660'     | 'Main Company' | 'Distribution department' | 'TRY'      | 'Trade agent 1' | ''                    |
		
				
		And I close all client application windows

Scenario: _046006 check Sales report from trade agent movements by the Register  "R5021 Revenues"
		And I close all client application windows
	* Select Sales report from trade agent
		Given I open hyperlink "e1cib/list/Document.SalesReportFromTradeAgent"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
	* Check movements by the Register  "R5021 Revenues"
		And I click "Registrations report" button
		And I select "R5021 Revenues" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | ''                    | ''          | ''                  | ''             | ''                        | ''                   | ''             | ''         | ''         | ''                    | ''                             |
			| 'Document registrations records'                            | ''                    | ''          | ''                  | ''             | ''                        | ''                   | ''             | ''         | ''         | ''                    | ''                             |
			| 'Register  "R5021 Revenues"'                                | ''                    | ''          | ''                  | ''             | ''                        | ''                   | ''             | ''         | ''         | ''                    | ''                             |
			| ''                                                          | 'Period'              | 'Resources' | ''                  | 'Dimensions'   | ''                        | ''                   | ''             | ''         | ''         | ''                    | ''                             |
			| ''                                                          | ''                    | 'Amount'    | 'Amount with taxes' | 'Company'      | 'Branch'                  | 'Profit loss center' | 'Revenue type' | 'Item key' | 'Currency' | 'Additional analytic' | 'Multi currency movement type' |
			| ''                                                          | '03.11.2022 10:53:35' | '34,24'     | '34,24'             | 'Main Company' | 'Distribution department' | ''                   | ''             | 'PZU'      | 'USD'      | ''                    | 'Reporting currency'           |
			| ''                                                          | '03.11.2022 10:53:35' | '71,9'      | '71,9'              | 'Main Company' | 'Distribution department' | ''                   | ''             | 'UNIQ'     | 'USD'      | ''                    | 'Reporting currency'           |
			| ''                                                          | '03.11.2022 10:53:35' | '178,05'    | '178,05'            | 'Main Company' | 'Distribution department' | ''                   | ''             | 'XS/Blue'  | 'USD'      | ''                    | 'Reporting currency'           |
			| ''                                                          | '03.11.2022 10:53:35' | '200'       | '200'               | 'Main Company' | 'Distribution department' | ''                   | ''             | 'PZU'      | 'TRY'      | ''                    | 'Local currency'               |
			| ''                                                          | '03.11.2022 10:53:35' | '200'       | '200'               | 'Main Company' | 'Distribution department' | ''                   | ''             | 'PZU'      | 'TRY'      | ''                    | 'TRY'                          |
			| ''                                                          | '03.11.2022 10:53:35' | '200'       | '200'               | 'Main Company' | 'Distribution department' | ''                   | ''             | 'PZU'      | 'TRY'      | ''                    | 'en description is empty'      |
			| ''                                                          | '03.11.2022 10:53:35' | '420'       | '420'               | 'Main Company' | 'Distribution department' | ''                   | ''             | 'UNIQ'     | 'TRY'      | ''                    | 'Local currency'               |
			| ''                                                          | '03.11.2022 10:53:35' | '420'       | '420'               | 'Main Company' | 'Distribution department' | ''                   | ''             | 'UNIQ'     | 'TRY'      | ''                    | 'TRY'                          |
			| ''                                                          | '03.11.2022 10:53:35' | '420'       | '420'               | 'Main Company' | 'Distribution department' | ''                   | ''             | 'UNIQ'     | 'TRY'      | ''                    | 'en description is empty'      |
			| ''                                                          | '03.11.2022 10:53:35' | '1 040'     | '1 040'             | 'Main Company' | 'Distribution department' | ''                   | ''             | 'XS/Blue'  | 'TRY'      | ''                    | 'Local currency'               |
			| ''                                                          | '03.11.2022 10:53:35' | '1 040'     | '1 040'             | 'Main Company' | 'Distribution department' | ''                   | ''             | 'XS/Blue'  | 'TRY'      | ''                    | 'TRY'                          |
			| ''                                                          | '03.11.2022 10:53:35' | '1 040'     | '1 040'             | 'Main Company' | 'Distribution department' | ''                   | ''             | 'XS/Blue'  | 'TRY'      | ''                    | 'en description is empty'      |		
		And I close all client application windows

Scenario: _046005 check Sales report from trade agent movements by the Register  "R8010 Trade agent inventory"
		And I close all client application windows
	* Select Sales report from trade agent
		Given I open hyperlink "e1cib/list/Document.SalesReportFromTradeAgent"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
	* Check movements by the Register  "R8010 Trade agent inventory"
		And I click "Registrations report" button
		And I select "R8010 Trade agent inventory" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | ''            | ''                    | ''          | ''             | ''         | ''              | ''                           |
			| 'Document registrations records'                            | ''            | ''                    | ''          | ''             | ''         | ''              | ''                           |
			| 'Register  "R8010 Trade agent inventory"'                   | ''            | ''                    | ''          | ''             | ''         | ''              | ''                           |
			| ''                                                          | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''         | ''              | ''                           |
			| ''                                                          | ''            | ''                    | 'Quantity'  | 'Company'      | 'Item key' | 'Partner'       | 'Agreement'                  |
			| ''                                                          | 'Expense'     | '03.11.2022 10:53:35' | '1'         | 'Main Company' | 'PZU'      | 'Trade agent 1' | 'Trade agent partner term 1' |
			| ''                                                          | 'Expense'     | '03.11.2022 10:53:35' | '2'         | 'Main Company' | 'XS/Blue'  | 'Trade agent 1' | 'Trade agent partner term 1' |
			| ''                                                          | 'Expense'     | '03.11.2022 10:53:35' | '2'         | 'Main Company' | 'UNIQ'     | 'Trade agent 1' | 'Trade agent partner term 1' |		
		And I close all client application windows

Scenario: _046006 check Sales report from trade agent movements by the Register  "R8011 Trade agent serial lot number"
		And I close all client application windows
	* Select Sales report from trade agent
		Given I open hyperlink "e1cib/list/Document.SalesReportFromTradeAgent"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
	* Check movements by the Register  "R8011 Trade agent serial lot number"
		And I click "Registrations report" button
		And I select "R8011 Trade agent serial lot number" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | ''            | ''                    | ''          | ''             | ''         | ''              | ''                           | ''                  |
			| 'Document registrations records'                            | ''            | ''                    | ''          | ''             | ''         | ''              | ''                           | ''                  |
			| 'Register  "R8011 Trade agent serial lot number"'           | ''            | ''                    | ''          | ''             | ''         | ''              | ''                           | ''                  |
			| ''                                                          | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''         | ''              | ''                           | ''                  |
			| ''                                                          | ''            | ''                    | 'Quantity'  | 'Company'      | 'Item key' | 'Partner'       | 'Agreement'                  | 'Serial lot number' |
			| ''                                                          | 'Expense'     | '03.11.2022 10:53:35' | '1'         | 'Main Company' | 'PZU'      | 'Trade agent 1' | 'Trade agent partner term 1' | '8908899879'        |
			| ''                                                          | 'Expense'     | '03.11.2022 10:53:35' | '2'         | 'Main Company' | 'UNIQ'     | 'Trade agent 1' | 'Trade agent partner term 1' | '899007790088'      |		
		And I close all client application windows

Scenario: _046007 check Sales report from trade agent movements by the Register  "T6020 Batch keys info"
		And I close all client application windows
	* Select Sales report from trade agent
		Given I open hyperlink "e1cib/list/Document.SalesReportFromTradeAgent"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
	* Check movements by the Register  "T6020 Batch keys info"
		And I click "Registrations report" button
		And I select "T6020 Batch keys info" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Sales report from trade agent 1 dated 03.11.2022 10:53:35' | ''                    | ''          | ''       | ''           | ''                  | ''             | ''                  | ''         | ''          | ''                       | ''         | ''               | ''              | ''                                     | ''                   | ''             | ''       | ''     | ''           | ''                | ''                  | ''                 |
			| 'Document registrations records'                            | ''                    | ''          | ''       | ''           | ''                  | ''             | ''                  | ''         | ''          | ''                       | ''         | ''               | ''              | ''                                     | ''                   | ''             | ''       | ''     | ''           | ''                | ''                  | ''                 |
			| 'Register  "T6020 Batch keys info"'                         | ''                    | ''          | ''       | ''           | ''                  | ''             | ''                  | ''         | ''          | ''                       | ''         | ''               | ''              | ''                                     | ''                   | ''             | ''       | ''     | ''           | ''                | ''                  | ''                 |
			| ''                                                          | 'Period'              | 'Resources' | ''       | ''           | ''                  | 'Dimensions'   | ''                  | ''         | ''          | ''                       | ''         | ''               | ''              | ''                                     | ''                   | ''             | ''       | ''     | ''           | ''                | ''                  | ''                 |
			| ''                                                          | ''                    | 'Quantity'  | 'Amount' | 'Amount tax' | 'Amount cost ratio' | 'Company'      | 'Store'             | 'Item key' | 'Direction' | 'Currency movement type' | 'Currency' | 'Batch document' | 'Sales invoice' | 'Row ID'                               | 'Profit loss center' | 'Expense type' | 'Branch' | 'Work' | 'Work sheet' | 'Batch consignor' | 'Serial lot number' | 'Source of origin' |
			| ''                                                          | '03.11.2022 10:53:35' | '1'         | ''       | ''           | ''                  | 'Main Company' | 'Trade agent store' | 'PZU'      | 'Expense'   | ''                       | ''         | ''               | ''              | '                                    ' | ''                   | ''             | ''       | ''     | ''           | ''                | ''                  | ''                 |
			| ''                                                          | '03.11.2022 10:53:35' | '2'         | ''       | ''           | ''                  | 'Main Company' | 'Trade agent store' | 'XS/Blue'  | 'Expense'   | ''                       | ''         | ''               | ''              | '                                    ' | ''                   | ''             | ''       | ''     | ''           | ''                | ''                  | ''                 |
			| ''                                                          | '03.11.2022 10:53:35' | '2'         | ''       | ''           | ''                  | 'Main Company' | 'Trade agent store' | 'UNIQ'     | 'Expense'   | ''                       | ''         | ''               | ''              | '                                    ' | ''                   | ''             | ''       | ''     | ''           | ''                | ''                  | ''                 |		
		And I close all client application windows