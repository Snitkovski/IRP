﻿#language: en
@tree
@Positive
@FillingDocuments

Feature: check copy lines from documents

Variables:
import "Variables.feature"

Background:
	Given I launch TestClient opening script or connect the existing one


	
Scenario: _0155100 preparation ( filling documents)
	When set True value to the constant
	And I close TestClient session
	Given I open new TestClient session or connect the existing one
	* Load info
		When Create information register Barcodes records
		When Create catalog Companies objects (own Second company)
		When Create catalog CashAccounts objects
		When Create catalog Agreements objects
		When Create catalog ObjectStatuses objects
		When Create catalog ItemKeys objects
		When Create catalog ItemTypes objects
		When Create catalog Units objects
		When Create catalog Items objects
		When Create catalog PriceTypes objects
		When Create catalog Specifications objects
		When Create chart of characteristic types AddAttributeAndProperty objects
		When Create catalog AddAttributeAndPropertySets objects
		When Create catalog AddAttributeAndPropertyValues objects
		When Create catalog Currencies objects
		When Create catalog Companies objects (Main company)
		When Create catalog Stores objects
		When Create catalog Partners objects
		When Create catalog Companies objects (partners company)
		When Create information register PartnerSegments records
		When Create catalog PartnerSegments objects
		When Create chart of characteristic types CurrencyMovementType objects
		When Create catalog TaxRates objects
		When Create catalog Taxes objects	
		When Create catalog Taxes objects (for work order)
		When Create information register TaxSettings records
		When Create information register PricesByItemKeys records
		When Create catalog IntegrationSettings objects
		When Create information register CurrencyRates records
		When Create catalog BusinessUnits objects
		When Create catalog ExpenseAndRevenueTypes objects
		When Create catalog Companies objects (second company Ferron BP)
		When Create catalog PartnersBankAccounts objects
		When Create catalog PlanningPeriods objects
		When create items for work order
		When Create catalog BillOfMaterials objects
		When Create catalog ItemKeys objects (serial lot numbers)
		When Create catalog ItemTypes objects (serial lot numbers)
		When Create catalog Items objects (serial lot numbers)
		When Create catalog SerialLotNumbers objects
		When update ItemKeys
	* Add plugin for taxes calculation
		Given I open hyperlink "e1cib/list/Catalog.ExternalDataProc"
		If "List" table does not contain lines Then
				| "Description" |
				| "TaxCalculateVAT_TR" |
			When add Plugin for tax calculation
		When Create catalog PartnerItems objects
		When Create information register Taxes records (VAT)
	* Tax settings
		When filling in Tax settings for company
	* Add sales tax
		When Create catalog Taxes objects (Sales tax)
		When Create information register TaxSettings (Sales tax)
		When Create information register Taxes records (Sales tax)
		When add sales tax settings 
		When Create catalog CancelReturnReasons objects
		When Create document SalesInvoice objects (for copy lines)


Scenario: _0154192 copy lines from SI to IT
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open IT and check copy lines
		Given I open hyperlink "e1cib/list/Document.InventoryTransfer"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| '#' | 'Item'               | 'Item key' | 'Serial lot numbers' | 'Unit'              | 'Source of origins' | 'Quantity' | 'Inventory transfer order' | 'Production planning' |
			| '1' | 'Product 1 with SLN' | 'PZU'      | '0512; 0514'         | 'pcs'               | ''                  | '3,000'    | ''                         | ''                    |
			| '2' | 'Dress'              | 'XS/Blue'  | ''                   | 'box Dress (8 pcs)' | ''                  | '2,000'    | ''                         | ''                    |
			| '3' | 'Product 3 with SLN' | 'UNIQ'     | '0514'               | 'pcs'               | ''                  | '2,000'    | ''                         | ''                    |
			| '4' | 'Product 3 with SLN' | 'PZU'      | ''                   | 'pcs'               | ''                  | '8,000'    | ''                         | ''                    |	
		And I close all client application windows

Scenario: _0154193 copy lines from SI to ISR
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open ISR and check copy lines
		Given I open hyperlink "e1cib/list/Document.InternalSupplyRequest"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | 'pcs'               | '8,000'    |
		And I close all client application windows	

Scenario: _0154194 copy lines from SI to ITO
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open ITO and check copy lines
		Given I open hyperlink "e1cib/list/Document.InventoryTransferOrder"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | 'pcs'               | '8,000'    |
		And I close all client application windows					

Scenario: _0154194 copy lines from SI to ItemStockAdjustment
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open ItemStockAdjustment and check copy lines
		Given I open hyperlink "e1cib/list/Document.ItemStockAdjustment"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key (surplus)' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'                | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'            | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'               | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'                | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _0154195 copy lines from SI to PlannedReceiptReservation
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open PlannedReceiptReservation and check copy lines
		Given I open hyperlink "e1cib/list/Document.PlannedReceiptReservation"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _0154196 copy lines from SI to PurchaseInvoice
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open PurchaseInvoice and check copy lines
		Given I open hyperlink "e1cib/list/Document.PurchaseInvoice"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Serial lot numbers' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | '0512; 0514'         | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | ''                   | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | '0514'               | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | ''                   | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _0154197 copy lines from SI to PurchaseOrder
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open PurchaseOrder and check copy lines
		Given I open hyperlink "e1cib/list/Document.PurchaseOrder"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _0154198 copy lines from SI to PurchaseReturn
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open PurchaseReturn and check copy lines
		Given I open hyperlink "e1cib/list/Document.PurchaseReturn"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Serial lot numbers' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | '0512; 0514'         | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | ''                   | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | '0514'               | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | ''                   | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _0154199 copy lines from SI to PurchaseReturnOrder
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open PurchaseReturnOrder and check copy lines
		Given I open hyperlink "e1cib/list/Document.PurchaseReturnOrder"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _01541991 copy lines from SI to RetailSalesReceipt
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open RetailSalesReceipt and check copy lines
		Given I open hyperlink "e1cib/list/Document.RetailSalesReceipt"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Serial lot numbers' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | '0512; 0514'         | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | ''                   | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | '0514'               | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | ''                   | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _01541992 copy lines from SI to SalesOrder
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open SalesOrder and check copy lines
		Given I open hyperlink "e1cib/list/Document.SalesOrder"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | 'pcs'               | '8,000'    |
	* Copy from SO to new SI
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I click the button named "FormCreate"
		And in the table "ItemList" I click "Paste from clipboard" button	
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _01541992 copy lines from SI to SalesOrderClosing
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open SalesOrderClosing and check copy lines
		Given I open hyperlink "e1cib/list/Document.SalesOrderClosing"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _01541993 copy lines from SI to SalesReportFromTradeAgent
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open SalesReportFromTradeAgent and check copy lines
		Given I open hyperlink "e1cib/list/Document.SalesReportFromTradeAgent"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Serial lot numbers' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | '0512; 0514'         | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | ''                   | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | '0514'               | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | ''                   | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _01541994 copy lines from SI to SalesReportToConsignor
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open SalesReportToConsignor and check copy lines
		Given I open hyperlink "e1cib/list/Document.SalesReportToConsignor"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Serial lot numbers' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | '0512; 0514'         | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | ''                   | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | '0514'               | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | ''                   | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _01541995 copy lines from SI to SalesReportToConsignor
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open SalesReportToConsignor and check copy lines
		Given I open hyperlink "e1cib/list/Document.SalesReportToConsignor"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Serial lot numbers' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | '0512; 0514'         | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | ''                   | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | '0514'               | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | ''                   | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _01541996 copy lines from SI to SalesReportToConsignor
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open SalesReportToConsignor and check copy lines
		Given I open hyperlink "e1cib/list/Document.SalesReportToConsignor"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Serial lot numbers' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | '0512; 0514'         | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | ''                   | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | '0514'               | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | ''                   | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _01541997 copy lines from SI to SalesReturn
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open SalesReturn and check copy lines
		Given I open hyperlink "e1cib/list/Document.SalesReturn"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Serial lot numbers' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | '0512; 0514'         | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | ''                   | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | '0514'               | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | ''                   | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _01541998 copy lines from SI to SalesReturnOrder
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open SalesReturnOrder and check copy lines
		Given I open hyperlink "e1cib/list/Document.SalesReturnOrder"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _01541999 copy lines from SI to ShipmentConfirmation
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open ShipmentConfirmation and check copy lines
		Given I open hyperlink "e1cib/list/Document.ShipmentConfirmation"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _01541981 copy lines from SI to StockAdjustmentAsSurplus
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open StockAdjustmentAsSurplus and check copy lines
		Given I open hyperlink "e1cib/list/Document.StockAdjustmentAsSurplus"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Serial lot numbers' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | '0512; 0514'         | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | ''                   | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | '0514'               | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | ''                   | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _01541981 copy lines from SI to StockAdjustmentAsWriteOff
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open StockAdjustmentAsWriteOff and check copy lines
		Given I open hyperlink "e1cib/list/Document.StockAdjustmentAsWriteOff"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Serial lot numbers' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | '0512; 0514'         | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | ''                   | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | '0514'               | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | ''                   | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _01541982 copy lines from SI to Unbundling
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open Unbundling and check copy lines
		Given I open hyperlink "e1cib/list/Document.Unbundling"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | 'pcs'               | '8,000'    |
		And I close all client application windows

Scenario: _01541982 copy lines from SI to Bundling
	And I close all client application windows
	* Select SI and copy lines
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		And I go to line in "List" table
			| 'Number' |
			| '1 290'  |
		And I select current line in "List" table
		And I click "Copy to clipboard" button
		And I click "Copy to clipboard" button
		And I go to line in "ItemList" table
			| 'Item'               | 'Item key' |
			| 'Product 1 with SLN' | 'PZU'      |
		Then I select all lines of "ItemList" table
		And I click "Copy to clipboard" button
	* Open Bundling and check copy lines
		Given I open hyperlink "e1cib/list/Document.Bundling"
		And I click the button named "FormCreate"
		And I click "Paste from clipboard" button
		And "ItemList" table became equal
			| 'Item'               | 'Item key' | 'Unit'              | 'Quantity' |
			| 'Product 1 with SLN' | 'PZU'      | 'pcs'               | '3,000'    |
			| 'Dress'              | 'XS/Blue'  | 'box Dress (8 pcs)' | '2,000'    |
			| 'Product 3 with SLN' | 'UNIQ'     | 'pcs'               | '2,000'    |
			| 'Product 3 with SLN' | 'PZU'      | 'pcs'               | '8,000'    |
		And I close all client application windows