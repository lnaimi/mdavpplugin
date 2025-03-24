package code.plugin.vp.Controllers;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.util.ArrayList;

import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.ListSelectionModel;
import javax.swing.SwingWorker;


import java.awt.BorderLayout;
import java.awt.Desktop;

import com.vp.plugin.ApplicationManager;
import com.vp.plugin.ViewManager;
import com.vp.plugin.action.VPAction;
import com.vp.plugin.action.VPActionController;
import com.vp.plugin.model.IProject;

import code.plugin.vp.GlobalConfig;
import code.plugin.vp.Structures.PDM;
import code.plugin.vp.Structures.Transformation;
import code.plugin.vp.UserInterface.PIMParameterizationDialogs.PDMChooserDialog;
import code.plugin.vp.Utilities.UserInterfaceUtil;
import code.plugin.vp.Utilities.XML;



public class CodeGenerationController implements VPActionController {

    @Override
    public void performAction(VPAction arg0) {
        //
        String savingPath = createSavingFolder();
        
        // get the pdm xml path
        ArrayList<String> pdmXMlPath = UserInterfaceUtil.getFilePath("Extensible Markup Language", "XML",null, "Select the PDMs file", false);

        if (pdmXMlPath.get(0) != null) {
            
            exportPIMasXML(savingPath);

            // Select Main PDM
            PDM selectedPdm = getMainPdm(XML.ImportPDMs(pdmXMlPath.get(0)));

            try {
                copyTransformations(selectedPdm, savingPath);
            } catch (IOException e) {
                ApplicationManager.instance().getViewManager().showMessage(e.getMessage());
            }

            // Create PDM transformations templates command
            String ttCommand = createTransformationCommand(selectedPdm, savingPath);

            // Run transformation template command line
            runTransformationCommand(ttCommand, savingPath);
        }
        
    }

    

    @Override
    public void update(VPAction arg0) {
       

    }

    private String createSavingFolder(){
        //Create the MDE Tool save Path in Documents
        IProject project = ApplicationManager.instance().getProjectManager().getProject();
        String documentPath = System.getProperty("user.home") + "\\Documents"+ "\\MDETool\\";
        UserInterfaceUtil.createFolder(documentPath);
        documentPath = documentPath +project.getName();
        UserInterfaceUtil.createFolder(documentPath);
        documentPath = documentPath +"\\Generated code";
        UserInterfaceUtil.createFolder(documentPath);

        return documentPath;
    }
    
    private void exportPIMasXML(String path){
        // Export parameterized PIM (Diagram) as "project.xml" to ditectory "Generated Code"
        //Exporting single model Not supported by open api we must export entire project
        //https://forums.visual-paradigm.com/t/how-to-export-one-or-more-diagrams-to-a-visual-paradigm-project-using-openapi/16407/7

        ApplicationManager.instance().getModelConvertionManager().exportXML(new File(path), true);
    }

    private PDM getMainPdm(ArrayList<PDM> pdms){
        ViewManager vm = ApplicationManager.instance().getViewManager();
        PDMChooserDialog pdmHandler = new PDMChooserDialog(pdms, "Select the main PDM", ListSelectionModel.SINGLE_SELECTION);
        vm.showDialog(pdmHandler);
        return pdmHandler.getPdm().iterator().next();
    }
    
    private void copyTransformations(PDM pdm, String savingPath) throws IOException {
        
        for (Transformation tt : pdm.getPdmTransformationTemplate()) {
            File ttFile = new File(tt.getFileUri().replace("\\", "\\\\"));
            Files.copy(ttFile.toPath(), new FileOutputStream(savingPath+"\\"+ttFile.getName(), true));
        }
    }

    private String createTransformationCommand(PDM pdm, String path){

        String command = "cd \""+path+"\" ";
        String SaxonicaTransformPath = "\""+UserInterfaceUtil.getFilePath("Executable", "exe", GlobalConfig.getSaxonicaPath(), "Choose Saxonica file path", false).get(0)+"\"";

        for (Transformation tt : pdm.getPdmTransformationTemplate()) {
            File ttFile = new File(tt.getFileUri().replace("\\", "\\\\"));
            command += "&& "+SaxonicaTransformPath+" -t project.xml "+ttFile.getName()+" ";
        }
        return command;
    }

    private void runTransformationCommand(String command, String savingPath){
        final JDialog loading = new JDialog();
        JPanel p1 = new JPanel(new BorderLayout());
        p1.add(new JLabel("Generating code..."), BorderLayout.CENTER);
        loading.setUndecorated(true);
        loading.getContentPane().add(p1);
        loading.pack();
        loading.setLocationRelativeTo(p1);
        loading.setDefaultCloseOperation(JDialog.DO_NOTHING_ON_CLOSE);
        loading.setModal(true);

        SwingWorker<String, Void> worker = new SwingWorker<String, Void>() {
            @Override
            protected String doInBackground() throws InterruptedException{
                /** Execute some operation */
                try 
                {
                    ProcessBuilder builder = new ProcessBuilder("cmd.exe", "/c", command);
                    builder.redirectErrorStream(true);
                    Process p = builder.start();
        
                    BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
                    String line;
                    while (true) {
                        line = r.readLine();
                        if (line == null) { break; }
                    }
                } catch (Exception e) {
                }
                return " "; 
            }
            
            
            @Override
            protected void done() {
                loading.dispose();
                //default title and icon
                Object[] options = {"OK","Open code", "Change location"};
                int n = JOptionPane.showOptionDialog(null, 
                    "Generating the code is done!! check \n\n"
                    +savingPath,
                    "Complete",
                    JOptionPane.YES_NO_CANCEL_OPTION,
                    JOptionPane.QUESTION_MESSAGE,
                    null,
                    options,
                    options[0]
                );

                if(n == 1){
                    try {
                        Desktop.getDesktop().open(new File(savingPath));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }

                if(n == 2) {
                    String newCodeLocation = UserInterfaceUtil.getDirectoryPath(savingPath, "Choose the new location of the generated code");
                    String projectName = ApplicationManager.instance().getProjectManager().getProject().getName();
                    String DestFodler = savingPath+"\\"+projectName;

                    UserInterfaceUtil.copyFolder(new File(DestFodler), new File (newCodeLocation));

                    Object[] options2 = {"OK","Open code"};
                    int n2 = JOptionPane.showOptionDialog(null, 
                        "Copying the source code Completed...!!!",
                        "Complete",
                        JOptionPane.YES_NO_CANCEL_OPTION,
                        JOptionPane.QUESTION_MESSAGE,
                        null,
                        options2,
                        options2[0]
                    );

                    if(n2 == 1){
                        try {
                            Desktop.getDesktop().open(new File(newCodeLocation));
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        };
        worker.execute();
        loading.setVisible(true);
        try {
            worker.get();
        } catch (Exception e1) {
            e1.printStackTrace();
        } 
    }
    
}