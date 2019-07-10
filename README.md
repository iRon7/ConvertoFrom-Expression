# ConvertoFrom-Expression
The ConvertoFrom-Expression cmdlet creates an object from a expression string, command scriptblock or file.

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

