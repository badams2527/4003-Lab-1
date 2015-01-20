package Lab2;

/**
 * Created by badams on 1/20/15.
 */
import java.applet.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

// Attempt at a simple handshake.  Girl pings Boy, gets confirmation.
// Then Boy pings girl, get confirmation.
class Monitor {
    String name;
    Boolean waiting = false;

    public Monitor (String name) { this.name = name; }

    public String getName() {  return this.name; }

    // Girl thread invokes ping, asks Boy to confirm.  But Boy invokes ping,
    // and asks Girl to confirm.  Neither Boy nor Girl can give time to their
    // confirm call because they are stuck in ping.  Hence the handshake
    // cannot be completed.
    public synchronized void ping (Monitor p) throws InterruptedException {
        System.out.println(this.name + " (ping): pinging " + p.getName());

        if (p.isWaiting()) {
            this.release(p);
        }

        this.waiting = true;
        synchronized (this) {
            this.wait();
        }
        //this.waiting = false;

        System.out.println(this.name + " (ping): asking " + p.getName() + " to confirm");
        p.confirm(this);
        System.out.println(this.name + " (ping): got confirmation");

        if (p.isWaiting()) {
            this.release(p);
        }
    }

    public synchronized void confirm (Monitor p) {
        System.out.println(this.name + " (confirm): confirm to " + p.getName());
    }

    public synchronized void release (Monitor p) {
        synchronized (p) {
            p.notify();
        }
    }

    public boolean isWaiting (){
        return waiting;
    }
}

class Runner extends Thread {
    Monitor m1, m2;

    public Runner (Monitor m1, Monitor m2) {
        this.m1 = m1;
        this.m2 = m2;
    }

    public void run () {
        try {
            m1.ping(m2);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}

public class DeadLock {
    public static void main (String args[]) {
        int i=1;
        System.out.println("Starting..."+(i++));
        Monitor a = new Monitor("Girl");
        Monitor b = new Monitor("Boy");
        (new Runner(a, b)).start();
        (new Runner(b, a)).start();
    }
}