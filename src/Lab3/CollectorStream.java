package Lab3;

import java.util.LinkedList;
import java.util.Queue;

/**
 * Created by badams on 2/9/15.
 */
public class CollectorStream extends Stream {
    Queue<Producer> producers = new LinkedList<Producer>();
    TCFrame t = null;
    Notifier n = null;
    double value = 0;

    public CollectorStream(){}

    public CollectorStream(Notifier n, TCFrame t) {
        // TODO: Add logic for this constructor
        this.t = t;
        this.n = n;
    }

    public void add(Producer p){
        producers.add(p);
    }

    public void start(){
        for (Producer p : producers){
            t.area.append("Collector: got " + p.ident + "\n");
            Subscriber s = (Subscriber)p.next();
            value += s.stock_value;
        }
    }

    synchronized public Object next () {
        n.putValue(new IntObject((int) value));
        return n;
    }
}
