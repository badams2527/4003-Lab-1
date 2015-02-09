package Lab3;

import java.util.LinkedList;
import java.util.Queue;

/**
 * Created by badams on 2/9/15.
 */
public class CollectorStream {
    Queue<Producer> producers = new LinkedList<Producer>();
    TCFrame t = null;

    public CollectorStream(Notifier n, TCFrame t) {
        // TODO: Add logic for this constructor
        this.t = t;
    }

    public void add(Producer p){
        producers.add(p);
        t.area.append("Collector: got " + p.ident + "\n");
    }

    public Object next(){
        // TODO: Add logic for this function
        return null;
    }

    public void start(){
        // TODO: Add logic for this function
    }


}
