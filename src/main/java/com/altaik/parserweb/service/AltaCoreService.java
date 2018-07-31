package com.altaik.parserweb.service;

import com.altaik.bo.Lot;
import com.altaik.parser.sendmails.ets.bo.ProcPurchase;
import org.apache.commons.io.FileUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.json.simple.JSONObject;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

class FileDownloadResponseHandler implements ResponseHandler<File> {

    private final File target;

    FileDownloadResponseHandler(File target) {
        this.target = target;
    }

    @Override
    public File handleResponse(HttpResponse response) throws IOException {
        InputStream source = response.getEntity().getContent();
        FileUtils.copyInputStreamToFile(source, this.target);

        return this.target;
    }

}

/**
 * @author Vladimir Kovalev (v.kovalev@altatender.kz) on 12.03.2018
 * @project sendmails
 */
public class AltaCoreService {
    private static final String ALTA_CORE_URL = "http://88.204.230.204:81/AltaCore";
    private static final int DEFAULT_MARKET = 4;
    private static final String DEFAULT_BROKER = "ТОО \"Корунд-777\"";
    private static final String DEFAULT_BROKER_CODE = "KORD";
    private static final String ORDER_FILE_EXTENSION = "docx";
    private static String tempDir = System.getProperty("java.io.tmpdir");

    private static String GetNewFileName(String extension) {
        return String.format("%s%s.%s", tempDir, UUID.randomUUID().toString(), extension);
    }

    public static File generateOrder(ProcPurchase purchase) throws IOException {
        String url = String.format("%s/api/DF/Fill/SupplierOrder", ALTA_CORE_URL);
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost post = new HttpPost(url);
        JSONObject object = new JSONObject();
        DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");

        object.put("SiteId", DEFAULT_MARKET);
        object.put("FromDate", dateFormat.format(new Date()));
        object.put("ClientBroker", purchase.organizer);
        object.put("OrderInitiator", purchase.customer);
        object.put("MemberCode", DEFAULT_BROKER_CODE);
        object.put("FullMemberName", DEFAULT_BROKER);

        if (purchase.lots != null && purchase.lots.size() > 0) {
            List<String> lotNumbers = new ArrayList<>();
            for (Lot lot : purchase.lots) {
                lotNumbers.add(lot.lotNumber.replaceAll("Лот\\s+№\\s+\\d\\s+", ""));
            }
            object.put("LotNumbers", lotNumbers);
        }

        String json = object.toString();
        post.setEntity(new StringEntity(json, ContentType.create("application/json", "utf-8")));
//        post.setHeader("Content-type", "application/json");

        File file = File.createTempFile("order", ".docx");
        file.deleteOnExit();
//        File file = new File(GetNewFileName(ORDER_FILE_EXTENSION));
//        file.createNewFile();

        return httpclient.execute(post, new FileDownloadResponseHandler(file));
    }
}
