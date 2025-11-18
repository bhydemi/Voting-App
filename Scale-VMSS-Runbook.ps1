# PowerShell Runbook to Scale VMSS
# This runbook scales up the VMSS when high CPU is detected

param(
    [Parameter(Mandatory=$false)]
    [string]$ResourceGroupName = "acdnd-c4-project",

    [Parameter(Mandatory=$false)]
    [string]$VMSSName = "udacity-vmss"
)

try {
    Write-Output "Starting VMSS scaling runbook..."
    Write-Output "Resource Group: $ResourceGroupName"
    Write-Output "VMSS Name: $VMSSName"

    # Authenticate using Managed Identity
    Write-Output "Authenticating with Managed Identity..."
    Connect-AzAccount -Identity

    # Get current VMSS configuration
    Write-Output "Getting current VMSS configuration..."
    $vmss = Get-AzVmss -ResourceGroupName $ResourceGroupName -VMScaleSetName $VMSSName
    $currentCapacity = $vmss.Sku.Capacity

    Write-Output "Current VMSS capacity: $currentCapacity"

    # Calculate new capacity (increase by 1, max 5)
    $newCapacity = [Math]::Min($currentCapacity + 1, 5)

    if ($newCapacity -eq $currentCapacity) {
        Write-Output "VMSS is already at maximum capacity ($currentCapacity instances)"
    } else {
        Write-Output "Scaling VMSS from $currentCapacity to $newCapacity instances..."

        # Update VMSS capacity
        $vmss.Sku.Capacity = $newCapacity
        Update-AzVmss -ResourceGroupName $ResourceGroupName -Name $VMSSName -VirtualMachineScaleSet $vmss

        Write-Output "Successfully scaled VMSS to $newCapacity instances"
    }

    Write-Output "Runbook execution completed successfully"
}
catch {
    Write-Error "Error occurred during runbook execution: $_"
    throw
}
