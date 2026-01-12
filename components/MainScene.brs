sub init()
    m.top.backgroundColor = "0x000000FF"  ' Black

    ' Start network detection when scene loads
    m.detector = m.top.findNode("NetworkDetector")  ' We'll add this node next
    if m.detector <> invalid
        m.detector.control = "RUN"
        m.detector.observeField("isLikelyTethered", "onDetectionComplete")
    end if

    ' Update welcome text (placeholder)
    m.welcome = m.top.findNode("welcomeLabel")
    m.welcome.text = "Proxy YouTube - Initializing..."
end sub

sub onDetectionComplete()
    if m.detector.isLikelyTethered
        m.welcome.text = "Mobile hotspot likely detected! " + m.detector.detectionReason
        ' Later: auto-enable proxy, show dialog, lower quality, etc.
    else
        m.welcome.text = "Normal connection detected"
    end if
end sub
