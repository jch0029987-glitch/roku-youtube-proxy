sub Main(args as Dynamic)
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    ' Create main scene
    scene = screen.CreateScene("MainScene")
    scene.observeField("exitApp", m.port)  ' Optional: for graceful exit

    screen.show()

    while(true)
        msg = wait(0, m.port)
        if type(msg) = "roSGScreenEvent"
            if msg.isScreenClosed() then exit while
        else if type(msg) = "roSGNodeEvent"
            if msg.getField() = "exitApp" and msg.getData() = true
                exit while
            end if
        end if
    end while
end sub
