sub init()
    m.top.functionName = "runDetection"
end sub

sub runDetection()
    isTethered = false
    reason = ""

    request = CreateObject("roUrlTransfer")
    request.SetUrl("https://1.1.1.1")  ' Fast Cloudflare DNS - low latency expected on normal WiFi
    request.SetTimeouts(4000, 4000)

    start = CreateObject("roDateTime").AsSeconds()
    response = request.GetToString()
    finish = CreateObject("roDateTime").AsSeconds()

    latency = (finish - start) * 1000  ' ms

    print "Ping latency: "; latency; " ms"

    if latency > 70
        isTethered = true
        reason = "High latency (" + latency.toStr() + "ms) - possible mobile hotspot/PdaNet+"
    else if latency > 40 and latency <= 70
        reason = "Moderate latency (" + latency.toStr() + "ms) - might be tethered"
    else
        reason = "Good latency (" + latency.toStr() + "ms)"
    end if

    ' Optional: Add more checks later (e.g., multiple pings for variance)

    m.top.isLikelyTethered = isTethered
    m.top.detectionReason = reason
    m.top.control = "DONE"
end sub
