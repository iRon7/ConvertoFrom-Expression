<#PSScriptInfo
.VERSION 1.0.0
.GUID 346b6ee5-a5f4-498f-b852-0f129bf6ec21
.AUTHOR Ronald Bode (iRon)
.DESCRIPTION Deserializes a object.
.COMPANYNAME
.COPYRIGHT
.TAGS Desrialize Invoke Expression ScriptBlock
.LICENSEURI https://github.com/iRon7/ConvertFrom-Expression/LICENSE.txt
.PROJECTURI https://github.com/iRon7/ConvertFrom-Expression
.ICONURI https://raw.githubusercontent.com/iRon7/ConvertFrom-Expression/master/ConvertFrom-Expression.png
.EXTERNALMODULEDEPENDENCIES
.REQUIREDSCRIPTS
.EXTERNALSCRIPTDEPENDENCIES
.RELEASENOTES
.PRIVATEDATA
#>

Function ConvertFrom-Expression {
<#
	.SYNOPSIS
		Deserializes a object.

	.DESCRIPTION
		The ConvertoFrom-Expression cmdlet creates an object from a expression
		string, command scriptblock or file.

	.INPUTS
		Sting or ScriptBlock. Each String or ScriptBlock provided through the
		pipeline will evaluted and converted to an PowerShell object.

	.OUTPUTS
		Any. One or more PowerShell objects.

	.PARAMETER Expression
		Specifies the expression or command to evaluate.

	.PARAMETER FilePath
		Specifies the path to the file containing an expression or command to
		be evaluated.

	.PARAMETER NoEnumerate
		Indicates that this cmdlet runs the expression in the current scope.
		By default, ConvertFrom-Expression runs commands in their own scope.

	.PARAMETER NoNewScope
		By default, the ConvertFrom-Expression cmdlet enumerates its output.
		The NoEnumerate parameter prevents the output enumerating.

	.EXAMPLE
		PS C:\> $Expression = ",[PSCustomObject]@{Name = 'Test'; Value = 123}"
		PS C:\> $Object = ConvertFrom-Expression -NoEnumerate $Expression
		PS C:\> $Object

		Name Value
		---- -----
		Test   123

		PS C:\> $Object -is [Array]
		True

	.LINK
		https://www.powershellgallery.com/packages/ConvertTo-Expression
#>

	[CmdletBinding()]Param (
		[Parameter(ParameterSetName = 'Expression', Position = 0, Mandatory = $True, ValueFromPipeLine = $True)]$Expression,
		[Parameter(ParameterSetName = 'FilePath', Position = 1, Mandatory = $True)][String[]]$FilePath, [Switch]$NoEnumerate, [Switch]$NoNewScope
	)
	Begin {
		Function Deserialize ($Expression) {
			Try {
				If ($NoEnumerate) {$Expression = "@{e=$Expression}"}
				If ($Expression -isnot [ScriptBlock]) {$Expression = [ScriptBlock]::Create($Expression)}
				$Object = Invoke-Command -NoNewScope:$NoNewScope $Expression
				If ($NoEnumerate) {Write-Output -NoEnumerate $Object['e']}
				Else {Write-Output $Object}
			} Catch {$PSCmdlet.WriteError($_)}
		}
	}
	Process {
		If ($Expression) {$Expression | ForEach-Object {Deserialize $_}}
		ElseIf ($FilePath) {$FilePath | ForEach-Object {Deserialize (Get-Content -Raw $_)}}
	}
}; Set-Alias cfex ConvertFrom-Expression